// SHA1 digest login. See BA doc for more information.

$(function() {
    $("#ba_loginbut").click(function() {
        var u=$('form input[name="ba_username"]').val();
        var s=$('form input[name="ba_seed"]').val();
        var realm=$('form input[name="ba_realm"]').val();
        var p=$('form input[name="ba_password"]');
        var p2=$('#ba_password2');
        var msg=$('#ba_info');
        
        if(u === "") {
            msg.text("Email address is empty!");
            return false;
        }
        if(p2.val() === "") {
            msg.text("Password is empty!");
            return false;
        }
        
        var hash = SHA1.hash(encodePassword(u, p2.val(), realm)+s);
        p.val(hash);
        
        return true;
    });
    $("#ba_changepw").click(function() {
        var u=$('form input[name="username"]').val();
        var realm=$('form input[name="realm"]').val();
        var op=$('form input[name="curPassword"]');
        var op2=$('#curPassword2');
        var np=$('form input[name="newPassword"]');
        var np2=$('#newPassword2');
        var npa=$('#againPassword');
        var msg=$('#ba_info');
        
        if(op2.val() === "") {
            msg.text("Current Password is empty!");
            return false;
        }
        if(np2.val() === "") {
            msg.text("New Password is empty!");
            return false;
        }
        if(np2.val() !== npa.val()) {
            msg.text("New Password Again is mismatched!");
            return false;
        }
        
        var curHash = encodePassword(u, op2.val(), realm);
        op.val(curHash);
        var nextHash = encodePassword(u, np2.val(), realm);
        np.val(nextHash);
        
        $.post("index.lsp?r=changepw", {
            username: u,
            realm: realm,
            curPassword: curHash,
            newPassword: nextHash
        }, function (resp) {
            if(resp.status) {
                msg.text("Password is changed! Please RELOGIN.");
                setTimeout(function() {
                  window.location.href = ".";
                }, 500);
            } else {
                msg.text("Current Password is mismatched!");
            }
        }, "json");
        return false;
    });
    $("#ba_addwallet").click(function() {
        var w=$('form input[name="walletName"]').val();
        var msg=$('#ba_info');
        if(!w || w === "") {
            msg.text("Name must not be empty!");
            return false;
        }
    });
    $("#ba_addentry").click(function() {
        var w=$('#entryWallet option:selected').val();
        var f=$('form input[name="entryFor"]').val();
        var time2=$('#entryWhen').val();
        var time=$('form input[name="entryWhen"]');
        var money=parseFloat($('form input[name="entryMoney"]').val());
        var msg=$('#ba_info');
        if(!w || w === "") {
            msg.text("Wallet must not be empty!");
            return false;
        }
        if(!f || f === "") {
            msg.text("For must not be empty!");
            return false;
        }
        if(!time2 ||  time2 === "") {
            msg.text("When must not be empty!");
            return false;
        } else {
            time2 = new Date(time2);
            if (isNaN(time2)) {
                msg.text("Date format 'mm dd, yyyy' is mismatched!");
                return false;
            }
            time2 = time2.getTime() / 1000;
        }
        if(money === 0) {
            msg.text("Money must no be zero!");
            return false;
        }
        
        time.val(time2);
        return true;
    });
$("#ba_addtransfer").click(function() {
        var f=$('#transferFrom option:selected').val();
        var t=$('#transferTo option:selected').val();
        var time2=$('#transferWhen').val();
        var time=$('form input[name="transferWhen"]');
        var money=parseFloat($('form input[name="transferMoney"]').val());
        var msg=$('#ba_info');
        
        if(!f || f === "") {
            msg.text("Wallet of From must not be empty!");
            return false;
        }
        
        if(!t || t === "") {
            msg.text("Wallet of To must not be empty!");
            return false;
        }
            
        if(f === t) {
            msg.text("Wallets of From and To must not be the same!");
            return false;
        }
        if(!time2 ||  time2 === "") {
            msg.text("When must not be empty!");
            return false;
        } else {
            time2 = new Date(time2);
            if (isNaN(time2)) {
                msg.text("Date format 'mm dd, yyyy' is mismatched!");
                return false;
            }
            time2 = time2.getTime() / 1000;
        }
        if(money === 0.00) {
            msg.text("Money must not be zero!");
            return false;
        }
        time.val(time2);
        
        return true;
    });
});

function encodePassword(user, pass, realm) {
    var spark = new SparkMD5();
    spark.append(utf8Encode(user));
    spark.append(":");
    spark.append(utf8Encode(realm));
    spark.append(":");
    spark.append(utf8Encode(pass));
    return spark.end();
}

function utf8Encode(s){var cc=String.fromCharCode;s=s.replace(/\r\n/g,"\n");var u="";for(var n=0;n<s.length;n++){var c=s.charCodeAt(n);if(c<128)u+=cc(c);else if((c>127)&&(c<2048)){u+=cc((c>>6)|192);u+=cc((c&63)|128);}else{u+=cc((c>>12)|224);u+=cc(((c>>6)&63)|128);u+=cc((c&63)|128);}}return u;};

SHA1=function(){var C=function(E,D,G,F){switch(E){case 0:return(D&G)^(~D&F);case 1:return D^G^F;case 2:return(D&G)^(D&F)^(G&F);case 3:return D^G^F}},B=function(D,E){return(D<<E)|(D>>>(32-E))},A=function(G){var F="",D,E;for(E=7;E>=0;E--){D=(G>>>(E*4))&15;F+=D.toString(16)}return F};return{hash:function(F){F+=String.fromCharCode(128);var I=[1518500249,1859775393,2400959708,3395469782],U=Math.ceil(F.length/4)+2,G=Math.ceil(U/16),H=new Array(G),X=0,Q=1732584193,P=4023233417,O=2562383102,L=271733878,J=3285377520,D=new Array(80),h,g,f,Z,Y,R,V;for(;X<G;X++){H[X]=new Array(16);for(V=0;V<16;V++){H[X][V]=(F.charCodeAt(X*64+V*4)<<24)|(F.charCodeAt(X*64+V*4+1)<<16)|(F.charCodeAt(X*64+V*4+2)<<8)|(F.charCodeAt(X*64+V*4+3))}}H[G-1][14]=((F.length-1)*8)/Math.pow(2,32);H[G-1][14]=Math.floor(H[G-1][14]);H[G-1][15]=((F.length-1)*8)&4294967295;for(X=0;X<G;X++){for(R=0;R<16;R++){D[R]=H[X][R]}for(R=16;R<80;R++){D[R]=B(D[R-3]^D[R-8]^D[R-14]^D[R-16],1)}h=Q;g=P;f=O;Z=L;Y=J;for(R=0;R<80;R++){var S=Math.floor(R/20),E=(B(h,5)+C(S,g,f,Z)+Y+I[S]+D[R])&4294967295;Y=Z;Z=f;f=B(g,30);g=h;h=E}Q=(Q+h)&4294967295;P=(P+g)&4294967295;O=(O+f)&4294967295;L=(L+Z)&4294967295;J=(J+Y)&4294967295}return A(Q)+A(P)+A(O)+A(L)+A(J)}}}();
