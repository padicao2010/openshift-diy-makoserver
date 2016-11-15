<html>
    <body>
        <h1>Barracuda App Server</h1>
        <p>Version: <?lsp
                print(ba.version())
            ?>
        </p>
        <h1>Lua</h1>
        <p>Version: <?lsp
                print(_VERSION)
            ?>
        </p>
    </body>
</html>
