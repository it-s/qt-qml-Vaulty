//Primary
var BLANK = "#FFF";
var WHITE = "#E3EAF7";
var BLACK = "#1B2934";
var LIGHT = Qt.lighter("#40E3EAF7");
var DARK = Qt.darker("#801B2934");
var THEME = "#5e275f";
var TINTED = "#40414770";
var TRANSPARENT = Qt.rgba(0,0,0,0);
var GRAY = "#C5CBD6";
var ACCENT1 = "#261435";
var ACCENT2 = "#414770";
var ACCENT3 = "#5B85AA";
var ACCENT4 = "#B991BA";
//Elements
var TEXT = BLACK;
var SUBTEXT = ACCENT2;
var TITLE = ACCENT3;
var HEAD = ACCENT3;
var PAGE = WHITE;
var MODAL = BLANK;
var BORDER = GRAY;
//var TOOLBAR = WHITE;
//var TOOLBAR_TEXT = TITLE;
var TOOLBAR = {
    DEFAULT: 'DEFAULT',
    THEME: 'THEME'
};
var toolbar = {
    DEFAULT: {
        COLOR: WHITE,
        ICON: ACCENT2,
        TEXT: TITLE
    },
    THEME: {
          COLOR: THEME,
          ICON: WHITE,
          TEXT: ACCENT4
    }
};
var SEARCHBAR = BLANK;
var EDITBAR = BLANK;
var LIST = {
    DEFAULT: 'DEFAULT',
    THEME: 'THEME'
};
var list = {
    DEFAULT: {
        ICON: TEXT,
        TEXT: TEXT,
        SUBTEXT: SUBTEXT,
        TITLE: TITLE,
        HEAD: HEAD,
        SELECT: LIGHT,
        HIGHLIGHT: TINTED
    }
};

var LIST_ITEM_TEXT = TEXT;
var LIST_ITEM_SUBTEXT = SUBTEXT;
var LIST_ITEM_TITLE = TITLE;
var LIST_ITEM_HEAD = HEAD;
var LIST_ITEM_SELECT = LIGHT;
var LIST_ITEM_HIGHLIGHT = TINTED;
var BUTTON = TRANSPARENT;
var BUTTON_BORDER = BORDER;
var BUTTON_TEXT = ACCENT2;
var BUTTON_TEXT_PRIMARY = THEME;
