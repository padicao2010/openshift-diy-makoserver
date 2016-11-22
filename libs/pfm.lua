local su = require "sqlutil"

local function getHA1(user, pass, realm)
    local ha1 = ba.crypto.hash("md5")(user)(":")(realm)(":")(pass)(true, "hex")
    return ha1
end

local function getLastMonth(year, month)
    if month > 1 then
        return year, month - 1
    else
        return year - 1, 12
    end
end

local function updateCache(app, con)
    local cur = assert(con:execute([[
SELECT id, name FROM pfm_wallet;
    ]]))
    local w =  {}
    local id, name = cur:fetch()
    while id do
        w[id] = name
        id, name = cur:fetch()
    end
    
    return w;
end

local function checkDB(app)
    return su.exist(app.DBFILE)
end

local function openDB(app)
    return su.open(app.DBFILE)
end

local function closeDB(sqenv, sqcon)
    return su.close(sqenv, sqcon)
end

local function initDB(app)
    _G.print("-- initialize sqlite")
    local sqenv, sqcon = openDB(app)
    assert(sqcon:execute([[
CREATE TABLE pfm_user (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    email CHAR(64) NOT NULL,
    password CHAR(64) NOT NULL
);
    ]]))
    assert(sqcon:execute([[
CREATE TABLE pfm_wallet (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name CHAR(24) UNIQUE NOT NULL,
    money REAL DEFAULT 0.0
);
    ]]))
    assert(sqcon:execute([[
CREATE TABLE pfm_entry (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    wallet INTEGER NOT NULL,
    aim CHAR(32) NOT NULL,
    site VARCHAR(64),
    money REAL DEFAULT 0.0,
    time INTEGER,
    FOREIGN KEY(wallet) REFERENCES pfm_wallet(id)
);
    ]]))
    assert(sqcon:execute([[
CREATE TABLE pfm_transfer (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    source INTEGER DEFAULT 0,
    dest INTEGER DEFAULT 0,
    aim VARCHAR(32),
    time INTEGER DEFAULT 0,
    money REAL DEFAULT 0.0,
    FOREIGN KEY(source) REFERENCES pfm_wallet(id),
    FOREIGN KEY(dest) REFERENCES pfm_wallet(id)
);
    ]]))
    assert(sqcon:execute([[
CREATE TABLE pfm_month (
    year INTEGER,
    month INTEGER,
    income REAL DEFAULT 0.0,
    outcome REAL DEFAULT 0.0,
    remain REAL DEFAULT 0.0,
    PRIMARY KEY(year, month)
);
    ]]))

    _G.print("-- Add initialized data into SQLite")
    local username = "yvanhom@hotmail.com"
    local password = getHA1(username, "admin", app.REALM)
    assert(sqcon:execute(string.format([[
INSERT INTO pfm_user (email, password) VALUES(%s, %s);
    ]], luasql.quotestr(username), luasql.quotestr(password))))

    local y, m = getLastMonth(tonumber(os.date("%Y")), tonumber(os.date("%m")))
    assert(sqcon:execute(string.format([[
INSERT INTO pfm_month VALUES(%d, %d, 0.0, 0.0, 0.0);
    ]], y, m)))
    
    assert(sqcon:execute(string.format([[
INSERT INTO pfm_wallet VALUES(1, "INCOME", 0);
    ]])))
    
    closeDB(sqenv, sqcon)
end

local function getPassword(app, user)
    local sqenv, sqcon = openDB(app)
    local cur = assert(sqcon:execute(string.format([[
SELECT password FROM pfm_user WHERE email=%s;
    ]], luasql.quotestr(user))))
    local realpass = cur:fetch() or ""
    closeDB(sqenv, sqcon)
    return realpass
end

local function checkPassword(con, user, pass)
    local cur = assert(con:execute(string.format([[
SELECT id FROM pfm_user WHERE email=%s AND password=%s;
    ]], luasql.quotestr(user), luasql.quotestr(pass))))
    return cur:fetch()
end

local function changePassword(con, user, pass)
    assert(con:execute(string.format([[
UPDATE pfm_user SET password=%s WHERE email=%s;
    ]], luasql.quotestr(pass), luasql.quotestr(user))))
end

local function getPageInfo(pageIndex, perPage, count)
    local pageCount = math.floor((count + perPage - 1) / perPage)
    
    if not pageIndex then
        pageIndex = 1
    else
        pageIndex = tonumber(pageIndex)
        if pageIndex == -1 then
            pageIndex = pageCount
        else
            if pageIndex > pageCount or pageIndex < 1 then
                pageIndex = 1
            end
        end
    end
    
    local offset = (pageIndex - 1) * perPage
    return pageIndex, pageCount, offset
end

local function getFilterNumber(filter)
    if filter then
        filter = tonumber(filter)
        if filter < 0 then
            filter = 0
        end
        return filter
    else
        return 0
    end    
end

local function getWalletCount(con)
    local cur = assert(con:execute([[
SELECT COUNT(*) FROM pfm_wallet;
    ]]));
    local c = assert(cur:fetch())
    return c
end

local function getWallets(con, offset, limit)
    local cur = assert(con:execute(string.format([[
SELECT * FROM pfm_wallet LIMIT %d, %d;
    ]], offset, limit)))
    local results = {}
    local id, name, money = cur:fetch()
    while id do
        table.insert(results, {id = id, name = name, money = money})
        id, name, money = cur:fetch()
    end
    return results
end

local function addWallet(con, name, money)
    name = luasql.quotestr(name)
    return con:execute(string.format([[
INSERT INTO pfm_wallet (name, money) VALUES (%s, %.2f);
    ]], name, money))
end

local function getEntryCount(con, filterWallet)
    local where = ""
    if filterWallet > 0 then
        where = string.format("WHERE wallet=%d", filterWallet)
    end
    local cur = assert(con:execute(string.format([[
SELECT COUNT(*) FROM pfm_entry %s;
    ]], where)));
    local c = assert(cur:fetch())
    return c
end

local function getEntries(con, filterWallet, offset, limit)
    local where = ""
    if filterWallet > 0 then
        where = string.format("WHERE wallet=%d", filterWallet)
    end
    local cur = assert(con:execute(string.format([[
SELECT * FROM pfm_entry 
%s 
ORDER BY id DESC
LIMIT %d, %d;
    ]], where, offset, limit)))
    local results = {}
    local id, wallet, aim, site, money, time = cur:fetch()
    while id do
        table.insert(results, {id = id, wallet = wallet, aim = aim, site = site, time = time, money = money})
        id, wallet, aim, site, money, time = cur:fetch()
    end
    return results
end

local function addEntry(con, wallet, aim, site, time, money)
    assert(con:execute("BEGIN;"))
    local sqlstr = string.format([[
INSERT INTO pfm_entry (wallet, aim, site, time, money) VALUES (%d, %s, %s, %d, %f);
    ]], wallet, luasql.quotestr(aim), luasql.quotestr(site), time, money);
    local cur = con:execute(sqlstr)
    if cur == nil then
        assert(con:execute("ROLLBACK;"))
        return nil, wallet .. "alread exists!"
    else
        cur = con:execute(string.format([[
UPDATE pfm_wallet SET money=money-%f WHERE id=%d;
        ]], money, wallet))
        if cur == nil then
            assert(con:execute("ROLLBACK;"))
            return nil, "Can'it update pfm_wallet!"
        else
            assert(con:execute("COMMIT;"))
            return true
        end
    end
end

local function getTransferCount(con, filterFrom, filterTo)
    local where = ""
    if filterFrom > 0 then
        where = string.format("WHERE source=%d", filterFrom)
        if filterTo > 0 then
            where = string.format("%s AND dest=%d", where, filterTo)
        end
    else
        if filterTo > 0 then
            where = string.format("WHERE dest=%d", filterTo)
        end
    end
    local cur = assert(con:execute(string.format([[
SELECT COUNT(*) FROM pfm_transfer %s;
    ]], where)))
    local c = assert(cur:fetch())
    return c
end

local function getTransfers(con, filterFrom, filterTo, offset, limit)
    local where = ""
    if filterFrom > 0 then
        where = string.format("WHERE source=%d", filterFrom)
        if filterTo > 0 then
            where = string.format("%s AND dest=%d", where, filterTo)
        end
    else
        if filterTo > 0 then
            where = string.format("WHERE dest=%d", filterTo)
        end
    end
    local cur = assert(con:execute(string.format([[
SELECT * FROM pfm_transfer 
%s 
ORDER BY id DESC
LIMIT %d, %d;
    ]], where, offset, limit)))
    local results = {}
    local id, source, dest, aim, time, money = cur:fetch()
    while id do
        table.insert(results, {id = id, source = source, dest = dest, aim = aim, money = money})
        id, source, dest, aim, time, money = cur:fetch()
    end
    return results
end

local function addTransfer(con, source, dest, time, aim, money)
    local sqlstr = string.format([[
INSERT INTO pfm_transfer (source, dest, time, aim, money) VALUES (%d, %d, %d, %s, %f);
        ]], source, dest, time, luasql.quotestr(aim), money);
    assert(con:execute("BEGIN;"))
    local cur = con:execute(sqlstr)
    if cur == nil then
        assert(con:execute("ROLLBACK;"))
        return nil, "wallets not exists!"
    else
        cur = con:execute(string.format([[
UPDATE pfm_wallet SET money=money-%f WHERE id=%d;
        ]], money, source))
        if cur == nil then
            assert(con:execute("ROLLBACK;"))
            return nil, "Can't update wallet of From!"
       else
            cur = con:execute(string.format([[
UPDATE pfm_wallet SET money=money+%f WHERE id=%d;
            ]], money, dest))
            if cur == nil then
                assert(con:execute("ROLLBACK;"))
                return nil, "Can't update wallet of To!"
            else
                assert(con:execute("COMMIT;"))
                return true
            end
       end
    end
end

return {
    updateCache = updateCache,
    
    checkDB = checkDB,
    initDB = initDB,
    openDB = openDB,
    closeDB = closeDB,
    
    getPassword = getPassword,
    checkPassword = checkPassword,
    changePassword = changePassword,
    
    getPageInfo = getPageInfo,
    getFilterNumber = getFilterNumber,
    
    getWalletCount = getWalletCount,
    getWallets = getWallets,
    addWallet = addWallet,
    
    getEntryCount = getEntryCount,
    getEntries = getEntries,
    addEntry = addEntry,
    
    getTransferCount = getTransferCount,
    getTransfers = getTransfers,
    addTransfer = addTransfer,
}
