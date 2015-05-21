var pick = function(src, min, max) {
    var n, chars = '';

    if (typeof max === 'undefined') {
        n = min;
    } else {
        n = min + Math.floor(Math.random() * (max - min));
    }

    for (var i = 0; i < n; i++) {
        chars += src.charAt(Math.floor(Math.random() * src.length));
    }

    return chars;
};


// Credit to @Christoph: http://stackoverflow.com/a/962890/464744
var shuffle = function(src) {
    var array = src.split('');
    var tmp, current, top = array.length;

    if (top) while (--top) {
        current = Math.floor(Math.random() * (top + 1));
        tmp = array[current];
        array[current] = array[top];
        array[top] = tmp;
    }

    return array.join('');
};

var specials = '!@#$%^&*()_+{}:"<>?\|[];\',./`~';
var lowercase = 'abcdefghijklmnopqrstuvwxyz';
var uppercase = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
var numbers = '0123456789';

var all = specials + lowercase + uppercase + numbers;

function generatePassword(){
    var password = '';
    password += pick(specials, 1);
    password += pick(lowercase, 1);
    password += pick(uppercase, 1);
    password += pick(all, 3, 10);
    password = shuffle(password);
    return password;
}

function generatePin(){
    var password = '';
    password += pick(numbers, 4);
    password = shuffle(password);
    return password;
}

function cleanURL(url) {
    return url.toLowerCase().replace("http://", "");
}

function formatURL(url) {
    if (url.indexOf("http://") < 0) return "http://" + url.toLowerCase();
}
