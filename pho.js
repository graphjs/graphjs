window["Pho"] =
/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};
/******/
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/
/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId]) {
/******/ 			return installedModules[moduleId].exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			i: moduleId,
/******/ 			l: false,
/******/ 			exports: {}
/******/ 		};
/******/
/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/
/******/ 		// Flag the module as loaded
/******/ 		module.l = true;
/******/
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/
/******/
/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;
/******/
/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;
/******/
/******/ 	// define getter function for harmony exports
/******/ 	__webpack_require__.d = function(exports, name, getter) {
/******/ 		if(!__webpack_require__.o(exports, name)) {
/******/ 			Object.defineProperty(exports, name, {
/******/ 				configurable: false,
/******/ 				enumerable: true,
/******/ 				get: getter
/******/ 			});
/******/ 		}
/******/ 	};
/******/
/******/ 	// getDefaultExport function for compatibility with non-harmony modules
/******/ 	__webpack_require__.n = function(module) {
/******/ 		var getter = module && module.__esModule ?
/******/ 			function getDefault() { return module['default']; } :
/******/ 			function getModuleExports() { return module; };
/******/ 		__webpack_require__.d(getter, 'a', getter);
/******/ 		return getter;
/******/ 	};
/******/
/******/ 	// Object.prototype.hasOwnProperty.call
/******/ 	__webpack_require__.o = function(object, property) { return Object.prototype.hasOwnProperty.call(object, property); };
/******/
/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";
/******/
/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(__webpack_require__.s = 76);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */
/***/ (function(module, exports, __webpack_require__) {

/* Riot v3.9.0, @license MIT */
(function (global, factory) {
	 true ? factory(exports) :
	typeof define === 'function' && define.amd ? define(['exports'], factory) :
	(factory((global.riot = {})));
}(this, (function (exports) { 'use strict';

/**
 * Shorter and fast way to select a single node in the DOM
 * @param   { String } selector - unique dom selector
 * @param   { Object } ctx - DOM node where the target of our search will is located
 * @returns { Object } dom node found
 */
function $(selector, ctx) {
  return (ctx || document).querySelector(selector)
}

var
  // be aware, internal usage
  // ATTENTION: prefix the global dynamic variables with `__`
  // tags instances cache
  __TAGS_CACHE = [],
  // tags implementation cache
  __TAG_IMPL = {},
  YIELD_TAG = 'yield',

  /**
   * Const
   */
  GLOBAL_MIXIN = '__global_mixin',

  // riot specific prefixes or attributes
  ATTRS_PREFIX = 'riot-',

  // Riot Directives
  REF_DIRECTIVES = ['ref', 'data-ref'],
  IS_DIRECTIVE = 'data-is',
  CONDITIONAL_DIRECTIVE = 'if',
  LOOP_DIRECTIVE = 'each',
  LOOP_NO_REORDER_DIRECTIVE = 'no-reorder',
  SHOW_DIRECTIVE = 'show',
  HIDE_DIRECTIVE = 'hide',
  KEY_DIRECTIVE = 'key',
  RIOT_EVENTS_KEY = '__riot-events__',

  // for typeof == '' comparisons
  T_STRING = 'string',
  T_OBJECT = 'object',
  T_UNDEF  = 'undefined',
  T_FUNCTION = 'function',

  XLINK_NS = 'http://www.w3.org/1999/xlink',
  SVG_NS = 'http://www.w3.org/2000/svg',
  XLINK_REGEX = /^xlink:(\w+)/,

  WIN = typeof window === T_UNDEF ? undefined : window,

  // special native tags that cannot be treated like the others
  RE_SPECIAL_TAGS = /^(?:t(?:body|head|foot|[rhd])|caption|col(?:group)?|opt(?:ion|group))$/,
  RE_SPECIAL_TAGS_NO_OPTION = /^(?:t(?:body|head|foot|[rhd])|caption|col(?:group)?)$/,
  RE_EVENTS_PREFIX = /^on/,
  RE_HTML_ATTRS = /([-\w]+) ?= ?(?:"([^"]*)|'([^']*)|({[^}]*}))/g,
  // some DOM attributes must be normalized
  CASE_SENSITIVE_ATTRIBUTES = {
    'viewbox': 'viewBox',
    'preserveaspectratio': 'preserveAspectRatio'
  },
  /**
   * Matches boolean HTML attributes in the riot tag definition.
   * With a long list like this, a regex is faster than `[].indexOf` in most browsers.
   * @const {RegExp}
   * @see [attributes.md](https://github.com/riot/compiler/blob/dev/doc/attributes.md)
   */
  RE_BOOL_ATTRS = /^(?:disabled|checked|readonly|required|allowfullscreen|auto(?:focus|play)|compact|controls|default|formnovalidate|hidden|ismap|itemscope|loop|multiple|muted|no(?:resize|shade|validate|wrap)?|open|reversed|seamless|selected|sortable|truespeed|typemustmatch)$/,
  // version# for IE 8-11, 0 for others
  IE_VERSION = (WIN && WIN.document || {}).documentMode | 0;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

/**
 * Create a generic DOM node
 * @param   { String } name - name of the DOM node we want to create
 * @returns { Object } DOM node just created
 */
function makeElement(name) {
  return name === 'svg' ? document.createElementNS(SVG_NS, name) : document.createElement(name)
}

/**
 * Set any DOM attribute
 * @param { Object } dom - DOM node we want to update
 * @param { String } name - name of the property we want to set
 * @param { String } val - value of the property we want to set
 */
function setAttribute(dom, name, val) {
  var xlink = XLINK_REGEX.exec(name);
  if (xlink && xlink[1])
    { dom.setAttributeNS(XLINK_NS, xlink[1], val); }
  else
    { dom.setAttribute(name, val); }
}

var styleNode;
// Create cache and shortcut to the correct property
var cssTextProp;
var byName = {};
var remainder = [];
var needsInject = false;

// skip the following code on the server
if (WIN) {
  styleNode = ((function () {
    // create a new style element with the correct type
    var newNode = makeElement('style');
    // replace any user node or insert the new one into the head
    var userNode = $('style[type=riot]');

    setAttribute(newNode, 'type', 'text/css');
    /* istanbul ignore next */
    if (userNode) {
      if (userNode.id) { newNode.id = userNode.id; }
      userNode.parentNode.replaceChild(newNode, userNode);
    } else { document.head.appendChild(newNode); }

    return newNode
  }))();
  cssTextProp = styleNode.styleSheet;
}

/**
 * Object that will be used to inject and manage the css of every tag instance
 */
var styleManager = {
  styleNode: styleNode,
  /**
   * Save a tag style to be later injected into DOM
   * @param { String } css - css string
   * @param { String } name - if it's passed we will map the css to a tagname
   */
  add: function add(css, name) {
    if (name) { byName[name] = css; }
    else { remainder.push(css); }
    needsInject = true;
  },
  /**
   * Inject all previously saved tag styles into DOM
   * innerHTML seems slow: http://jsperf.com/riot-insert-style
   */
  inject: function inject() {
    if (!WIN || !needsInject) { return }
    needsInject = false;
    var style = Object.keys(byName)
      .map(function (k) { return byName[k]; })
      .concat(remainder).join('\n');
    /* istanbul ignore next */
    if (cssTextProp) { cssTextProp.cssText = style; }
    else { styleNode.innerHTML = style; }
  }
}

/**
 * The riot template engine
 * @version v3.0.8
 */

var skipRegex = (function () { //eslint-disable-line no-unused-vars

  var beforeReChars = '[{(,;:?=|&!^~>%*/';

  var beforeReWords = [
    'case',
    'default',
    'do',
    'else',
    'in',
    'instanceof',
    'prefix',
    'return',
    'typeof',
    'void',
    'yield'
  ];

  var wordsLastChar = beforeReWords.reduce(function (s, w) {
    return s + w.slice(-1)
  }, '');

  var RE_REGEX = /^\/(?=[^*>/])[^[/\\]*(?:(?:\\.|\[(?:\\.|[^\]\\]*)*\])[^[\\/]*)*?\/[gimuy]*/;
  var RE_VN_CHAR = /[$\w]/;

  function prev (code, pos) {
    while (--pos >= 0 && /\s/.test(code[pos])){ }
    return pos
  }

  function _skipRegex (code, start) {

    var re = /.*/g;
    var pos = re.lastIndex = start++;
    var match = re.exec(code)[0].match(RE_REGEX);

    if (match) {
      var next = pos + match[0].length;

      pos = prev(code, pos);
      var c = code[pos];

      if (pos < 0 || ~beforeReChars.indexOf(c)) {
        return next
      }

      if (c === '.') {

        if (code[pos - 1] === '.') {
          start = next;
        }

      } else if (c === '+' || c === '-') {

        if (code[--pos] !== c ||
            (pos = prev(code, pos)) < 0 ||
            !RE_VN_CHAR.test(code[pos])) {
          start = next;
        }

      } else if (~wordsLastChar.indexOf(c)) {

        var end = pos + 1;

        while (--pos >= 0 && RE_VN_CHAR.test(code[pos])){ }
        if (~beforeReWords.indexOf(code.slice(pos + 1, end))) {
          start = next;
        }
      }
    }

    return start
  }

  return _skipRegex

})();

/**
 * riot.util.brackets
 *
 * - `brackets    ` - Returns a string or regex based on its parameter
 * - `brackets.set` - Change the current riot brackets
 *
 * @module
 */

/* global riot */

/* istanbul ignore next */
var brackets = (function (UNDEF) {

  var
    REGLOB = 'g',

    R_MLCOMMS = /\/\*[^*]*\*+(?:[^*\/][^*]*\*+)*\//g,

    R_STRINGS = /"[^"\\]*(?:\\[\S\s][^"\\]*)*"|'[^'\\]*(?:\\[\S\s][^'\\]*)*'|`[^`\\]*(?:\\[\S\s][^`\\]*)*`/g,

    S_QBLOCKS = R_STRINGS.source + '|' +
      /(?:\breturn\s+|(?:[$\w\)\]]|\+\+|--)\s*(\/)(?![*\/]))/.source + '|' +
      /\/(?=[^*\/])[^[\/\\]*(?:(?:\[(?:\\.|[^\]\\]*)*\]|\\.)[^[\/\\]*)*?([^<]\/)[gim]*/.source,

    UNSUPPORTED = RegExp('[\\' + 'x00-\\x1F<>a-zA-Z0-9\'",;\\\\]'),

    NEED_ESCAPE = /(?=[[\]()*+?.^$|])/g,

    S_QBLOCK2 = R_STRINGS.source + '|' + /(\/)(?![*\/])/.source,

    FINDBRACES = {
      '(': RegExp('([()])|'   + S_QBLOCK2, REGLOB),
      '[': RegExp('([[\\]])|' + S_QBLOCK2, REGLOB),
      '{': RegExp('([{}])|'   + S_QBLOCK2, REGLOB)
    },

    DEFAULT = '{ }';;;;;;;;;

  var _pairs = [
    '{', '}',
    '{', '}',
    /{[^}]*}/,
    /\\([{}])/g,
    /\\({)|{/g,
    RegExp('\\\\(})|([[({])|(})|' + S_QBLOCK2, REGLOB),
    DEFAULT,
    /^\s*{\^?\s*([$\w]+)(?:\s*,\s*(\S+))?\s+in\s+(\S.*)\s*}/,
    /(^|[^\\]){=[\S\s]*?}/
  ];

  var
    cachedBrackets = UNDEF,
    _regex,
    _cache = [],
    _settings;;;;

  function _loopback (re) { return re }

  function _rewrite (re, bp) {
    if (!bp) { bp = _cache; }
    return new RegExp(
      re.source.replace(/{/g, bp[2]).replace(/}/g, bp[3]), re.global ? REGLOB : ''
    )
  }

  function _create (pair) {
    if (pair === DEFAULT) { return _pairs }

    var arr = pair.split(' ');

    if (arr.length !== 2 || UNSUPPORTED.test(pair)) {
      throw new Error('Unsupported brackets "' + pair + '"')
    }
    arr = arr.concat(pair.replace(NEED_ESCAPE, '\\').split(' '));

    arr[4] = _rewrite(arr[1].length > 1 ? /{[\S\s]*?}/ : _pairs[4], arr);
    arr[5] = _rewrite(pair.length > 3 ? /\\({|})/g : _pairs[5], arr);
    arr[6] = _rewrite(_pairs[6], arr);
    arr[7] = RegExp('\\\\(' + arr[3] + ')|([[({])|(' + arr[3] + ')|' + S_QBLOCK2, REGLOB);
    arr[8] = pair;
    return arr
  }

  function _brackets (reOrIdx) {
    return reOrIdx instanceof RegExp ? _regex(reOrIdx) : _cache[reOrIdx]
  }

  _brackets.split = function split (str, tmpl, _bp) {
    // istanbul ignore next: _bp is for the compiler
    if (!_bp) { _bp = _cache; }

    var
      parts = [],
      match,
      isexpr,
      start,
      pos,
      re = _bp[6];;;;;;

    var qblocks = [];
    var prevStr = '';
    var mark, lastIndex;;

    isexpr = start = re.lastIndex = 0;

    while ((match = re.exec(str))) {

      lastIndex = re.lastIndex;
      pos = match.index;

      if (isexpr) {

        if (match[2]) {

          var ch = match[2];
          var rech = FINDBRACES[ch];
          var ix = 1;

          rech.lastIndex = lastIndex;
          while ((match = rech.exec(str))) {
            if (match[1]) {
              if (match[1] === ch) { ++ix; }
              else if (!--ix) { break }
            } else {
              rech.lastIndex = pushQBlock(match.index, rech.lastIndex, match[2]);
            }
          }
          re.lastIndex = ix ? str.length : rech.lastIndex;
          continue
        }

        if (!match[3]) {
          re.lastIndex = pushQBlock(pos, lastIndex, match[4]);
          continue
        }
      }

      if (!match[1]) {
        unescapeStr(str.slice(start, pos));
        start = re.lastIndex;
        re = _bp[6 + (isexpr ^= 1)];
        re.lastIndex = start;
      }
    }

    if (str && start < str.length) {
      unescapeStr(str.slice(start));
    }

    parts.qblocks = qblocks;

    return parts

    function unescapeStr (s) {
      if (prevStr) {
        s = prevStr + s;
        prevStr = '';
      }
      if (tmpl || isexpr) {
        parts.push(s && s.replace(_bp[5], '$1'));
      } else {
        parts.push(s);
      }
    }

    function pushQBlock(_pos, _lastIndex, slash) { //eslint-disable-line
      if (slash) {
        _lastIndex = skipRegex(str, _pos);
      }

      if (tmpl && _lastIndex > _pos + 2) {
        mark = '\u2057' + qblocks.length + '~';
        qblocks.push(str.slice(_pos, _lastIndex));
        prevStr += str.slice(start, _pos) + mark;
        start = _lastIndex;
      }
      return _lastIndex
    }
  };

  _brackets.hasExpr = function hasExpr (str) {
    return _cache[4].test(str)
  };

  _brackets.loopKeys = function loopKeys (expr) {
    var m = expr.match(_cache[9]);

    return m
      ? { key: m[1], pos: m[2], val: _cache[0] + m[3].trim() + _cache[1] }
      : { val: expr.trim() }
  };

  _brackets.array = function array (pair) {
    return pair ? _create(pair) : _cache
  };

  function _reset (pair) {
    if ((pair || (pair = DEFAULT)) !== _cache[8]) {
      _cache = _create(pair);
      _regex = pair === DEFAULT ? _loopback : _rewrite;
      _cache[9] = _regex(_pairs[9]);
    }
    cachedBrackets = pair;
  }

  function _setSettings (o) {
    var b;

    o = o || {};
    b = o.brackets;
    Object.defineProperty(o, 'brackets', {
      set: _reset,
      get: function () { return cachedBrackets },
      enumerable: true
    });
    _settings = o;
    _reset(b);
  }

  Object.defineProperty(_brackets, 'settings', {
    set: _setSettings,
    get: function () { return _settings }
  });

  /* istanbul ignore next: in the browser riot is always in the scope */
  _brackets.settings = typeof riot !== 'undefined' && riot.settings || {};
  _brackets.set = _reset;
  _brackets.skipRegex = skipRegex;

  _brackets.R_STRINGS = R_STRINGS;
  _brackets.R_MLCOMMS = R_MLCOMMS;
  _brackets.S_QBLOCKS = S_QBLOCKS;
  _brackets.S_QBLOCK2 = S_QBLOCK2;

  return _brackets

})();

/**
 * @module tmpl
 *
 * tmpl          - Root function, returns the template value, render with data
 * tmpl.hasExpr  - Test the existence of a expression inside a string
 * tmpl.loopKeys - Get the keys for an 'each' loop (used by `_each`)
 */

/* istanbul ignore next */
var tmpl = (function () {

  var _cache = {};

  function _tmpl (str, data) {
    if (!str) { return str }

    return (_cache[str] || (_cache[str] = _create(str))).call(
      data, _logErr.bind({
        data: data,
        tmpl: str
      })
    )
  }

  _tmpl.hasExpr = brackets.hasExpr;

  _tmpl.loopKeys = brackets.loopKeys;

  // istanbul ignore next
  _tmpl.clearCache = function () { _cache = {}; };

  _tmpl.errorHandler = null;

  function _logErr (err, ctx) {

    err.riotData = {
      tagName: ctx && ctx.__ && ctx.__.tagName,
      _riot_id: ctx && ctx._riot_id  //eslint-disable-line camelcase
    };

    if (_tmpl.errorHandler) { _tmpl.errorHandler(err); }
    else if (
      typeof console !== 'undefined' &&
      typeof console.error === 'function'
    ) {
      console.error(err.message);
      console.log('<%s> %s', err.riotData.tagName || 'Unknown tag', this.tmpl); // eslint-disable-line
      console.log(this.data); // eslint-disable-line
    }
  }

  function _create (str) {
    var expr = _getTmpl(str);

    if (expr.slice(0, 11) !== 'try{return ') { expr = 'return ' + expr; }

    return new Function('E', expr + ';')    // eslint-disable-line no-new-func
  }

  var RE_DQUOTE = /\u2057/g;
  var RE_QBMARK = /\u2057(\d+)~/g;

  function _getTmpl (str) {
    var parts = brackets.split(str.replace(RE_DQUOTE, '"'), 1);
    var qstr = parts.qblocks;
    var expr;

    if (parts.length > 2 || parts[0]) {
      var i, j, list = [];;;

      for (i = j = 0; i < parts.length; ++i) {

        expr = parts[i];

        if (expr && (expr = i & 1

            ? _parseExpr(expr, 1, qstr)

            : '"' + expr
                .replace(/\\/g, '\\\\')
                .replace(/\r\n?|\n/g, '\\n')
                .replace(/"/g, '\\"') +
              '"'

          )) { list[j++] = expr; }

      }

      expr = j < 2 ? list[0]
           : '[' + list.join(',') + '].join("")';

    } else {

      expr = _parseExpr(parts[1], 0, qstr);
    }

    if (qstr.length) {
      expr = expr.replace(RE_QBMARK, function (_, pos) {
        return qstr[pos]
          .replace(/\r/g, '\\r')
          .replace(/\n/g, '\\n')
      });
    }
    return expr
  }

  var RE_CSNAME = /^(?:(-?[_A-Za-z\xA0-\xFF][-\w\xA0-\xFF]*)|\u2057(\d+)~):/;
  var
    RE_BREND = {
      '(': /[()]/g,
      '[': /[[\]]/g,
      '{': /[{}]/g
    };

  function _parseExpr (expr, asText, qstr) {

    expr = expr
      .replace(/\s+/g, ' ').trim()
      .replace(/\ ?([[\({},?\.:])\ ?/g, '$1');

    if (expr) {
      var
        list = [],
        cnt = 0,
        match;;;

      while (expr &&
            (match = expr.match(RE_CSNAME)) &&
            !match.index
        ) {
        var
          key,
          jsb,
          re = /,|([[{(])|$/g;;;

        expr = RegExp.rightContext;
        key  = match[2] ? qstr[match[2]].slice(1, -1).trim().replace(/\s+/g, ' ') : match[1];

        while (jsb = (match = re.exec(expr))[1]) { skipBraces(jsb, re); }

        jsb  = expr.slice(0, match.index);
        expr = RegExp.rightContext;

        list[cnt++] = _wrapExpr(jsb, 1, key);
      }

      expr = !cnt ? _wrapExpr(expr, asText)
           : cnt > 1 ? '[' + list.join(',') + '].join(" ").trim()' : list[0];
    }
    return expr

    function skipBraces (ch, re) {
      var
        mm,
        lv = 1,
        ir = RE_BREND[ch];;;

      ir.lastIndex = re.lastIndex;
      while (mm = ir.exec(expr)) {
        if (mm[0] === ch) { ++lv; }
        else if (!--lv) { break }
      }
      re.lastIndex = lv ? expr.length : ir.lastIndex;
    }
  }

  // istanbul ignore next: not both
  var // eslint-disable-next-line max-len
    JS_CONTEXT = '"in this?this:' + (typeof window !== 'object' ? 'global' : 'window') + ').',
    JS_VARNAME = /[,{][\$\w]+(?=:)|(^ *|[^$\w\.{])(?!(?:typeof|true|false|null|undefined|in|instanceof|is(?:Finite|NaN)|void|NaN|new|Date|RegExp|Math)(?![$\w]))([$_A-Za-z][$\w]*)/g,
    JS_NOPROPS = /^(?=(\.[$\w]+))\1(?:[^.[(]|$)/;;;

  function _wrapExpr (expr, asText, key) {
    var tb;

    expr = expr.replace(JS_VARNAME, function (match, p, mvar, pos, s) {
      if (mvar) {
        pos = tb ? 0 : pos + match.length;

        if (mvar !== 'this' && mvar !== 'global' && mvar !== 'window') {
          match = p + '("' + mvar + JS_CONTEXT + mvar;
          if (pos) { tb = (s = s[pos]) === '.' || s === '(' || s === '['; }
        } else if (pos) {
          tb = !JS_NOPROPS.test(s.slice(pos));
        }
      }
      return match
    });

    if (tb) {
      expr = 'try{return ' + expr + '}catch(e){E(e,this)}';
    }

    if (key) {

      expr = (tb
          ? 'function(){' + expr + '}.call(this)' : '(' + expr + ')'
        ) + '?"' + key + '":""';

    } else if (asText) {

      expr = 'function(v){' + (tb
          ? expr.replace('return ', 'v=') : 'v=(' + expr + ')'
        ) + ';return v||v===0?v:""}.call(this)';
    }

    return expr
  }

  _tmpl.version = brackets.version = 'v3.0.8';

  return _tmpl

})();

/* istanbul ignore next */
var observable = function(el) {

  /**
   * Extend the original object or create a new empty one
   * @type { Object }
   */

  el = el || {};

  /**
   * Private variables
   */
  var callbacks = {},
    slice = Array.prototype.slice;;

  /**
   * Public Api
   */

  // extend the el object adding the observable methods
  Object.defineProperties(el, {
    /**
     * Listen to the given `event` ands
     * execute the `callback` each time an event is triggered.
     * @param  { String } event - event id
     * @param  { Function } fn - callback function
     * @returns { Object } el
     */
    on: {
      value: function(event, fn) {
        if (typeof fn == 'function')
          { (callbacks[event] = callbacks[event] || []).push(fn); }
        return el
      },
      enumerable: false,
      writable: false,
      configurable: false
    },

    /**
     * Removes the given `event` listeners
     * @param   { String } event - event id
     * @param   { Function } fn - callback function
     * @returns { Object } el
     */
    off: {
      value: function(event, fn) {
        if (event == '*' && !fn) { callbacks = {}; }
        else {
          if (fn) {
            var arr = callbacks[event];
            for (var i = 0, cb; cb = arr && arr[i]; ++i) {
              if (cb == fn) { arr.splice(i--, 1); }
            }
          } else { delete callbacks[event]; }
        }
        return el
      },
      enumerable: false,
      writable: false,
      configurable: false
    },

    /**
     * Listen to the given `event` and
     * execute the `callback` at most once
     * @param   { String } event - event id
     * @param   { Function } fn - callback function
     * @returns { Object } el
     */
    one: {
      value: function(event, fn) {
        function on() {
          el.off(event, on);
          fn.apply(el, arguments);
        }
        return el.on(event, on)
      },
      enumerable: false,
      writable: false,
      configurable: false
    },

    /**
     * Execute all callback functions that listen to
     * the given `event`
     * @param   { String } event - event id
     * @returns { Object } el
     */
    trigger: {
      value: function(event) {
        var arguments$1 = arguments;


        // getting the arguments
        var arglen = arguments.length - 1,
          args = new Array(arglen),
          fns,
          fn,
          i;;;;;

        for (i = 0; i < arglen; i++) {
          args[i] = arguments$1[i + 1]; // skip first argument
        }

        fns = slice.call(callbacks[event] || [], 0);

        for (i = 0; fn = fns[i]; ++i) {
          fn.apply(el, args);
        }

        if (callbacks['*'] && event != '*')
          { el.trigger.apply(el, ['*', event].concat(args)); }

        return el
      },
      enumerable: false,
      writable: false,
      configurable: false
    }
  });

  return el

};

/**
 * Short alias for Object.getOwnPropertyDescriptor
 */
function getPropDescriptor (o, k) {
  return Object.getOwnPropertyDescriptor(o, k)
}

/**
 * Check if passed argument is undefined
 * @param   { * } value -
 * @returns { Boolean } -
 */
function isUndefined(value) {
  return typeof value === T_UNDEF
}

/**
 * Check whether object's property could be overridden
 * @param   { Object }  obj - source object
 * @param   { String }  key - object property
 * @returns { Boolean } true if writable
 */
function isWritable(obj, key) {
  var descriptor = getPropDescriptor(obj, key);
  return isUndefined(obj[key]) || descriptor && descriptor.writable
}

/**
 * Extend any object with other properties
 * @param   { Object } src - source object
 * @returns { Object } the resulting extended object
 *
 * var obj = { foo: 'baz' }
 * extend(obj, {bar: 'bar', foo: 'bar'})
 * console.log(obj) => {bar: 'bar', foo: 'bar'}
 *
 */
function extend(src) {
  var obj;
  var i = 1;
  var args = arguments;
  var l = args.length;

  for (; i < l; i++) {
    if (obj = args[i]) {
      for (var key in obj) {
        // check if this property of the source object could be overridden
        if (isWritable(src, key))
          { src[key] = obj[key]; }
      }
    }
  }
  return src
}

/**
 * Alias for Object.create
 */
function create(src) {
  return Object.create(src)
}

var settings = extend(create(brackets.settings), {
  skipAnonymousTags: true,
  // handle the auto updates on any DOM event
  autoUpdate: true
})

/**
 * Shorter and fast way to select multiple nodes in the DOM
 * @param   { String } selector - DOM selector
 * @param   { Object } ctx - DOM node where the targets of our search will is located
 * @returns { Object } dom nodes found
 */
function $$(selector, ctx) {
  return [].slice.call((ctx || document).querySelectorAll(selector))
}

/**
 * Create a document text node
 * @returns { Object } create a text node to use as placeholder
 */
function createDOMPlaceholder() {
  return document.createTextNode('')
}

/**
 * Toggle the visibility of any DOM node
 * @param   { Object }  dom - DOM node we want to hide
 * @param   { Boolean } show - do we want to show it?
 */

function toggleVisibility(dom, show) {
  dom.style.display = show ? '' : 'none';
  dom.hidden = show ? false : true;
}

/**
 * Get the value of any DOM attribute on a node
 * @param   { Object } dom - DOM node we want to parse
 * @param   { String } name - name of the attribute we want to get
 * @returns { String | undefined } name of the node attribute whether it exists
 */
function getAttribute(dom, name) {
  return dom.getAttribute(name)
}

/**
 * Remove any DOM attribute from a node
 * @param   { Object } dom - DOM node we want to update
 * @param   { String } name - name of the property we want to remove
 */
function removeAttribute(dom, name) {
  dom.removeAttribute(name);
}

/**
 * Set the inner html of any DOM node SVGs included
 * @param { Object } container - DOM node where we'll inject new html
 * @param { String } html - html to inject
 * @param { Boolean } isSvg - svg tags should be treated a bit differently
 */
/* istanbul ignore next */
function setInnerHTML(container, html, isSvg) {
  // innerHTML is not supported on svg tags so we neet to treat them differently
  if (isSvg) {
    var node = container.ownerDocument.importNode(
      new DOMParser()
        .parseFromString(("<svg xmlns=\"" + SVG_NS + "\">" + html + "</svg>"), 'application/xml')
        .documentElement,
      true
    );

    container.appendChild(node);
  } else {
    container.innerHTML = html;
  }
}

/**
 * Minimize risk: only zero or one _space_ between attr & value
 * @param   { String }   html - html string we want to parse
 * @param   { Function } fn - callback function to apply on any attribute found
 */
function walkAttributes(html, fn) {
  if (!html) { return }
  var m;
  while (m = RE_HTML_ATTRS.exec(html))
    { fn(m[1].toLowerCase(), m[2] || m[3] || m[4]); }
}

/**
 * Create a document fragment
 * @returns { Object } document fragment
 */
function createFragment() {
  return document.createDocumentFragment()
}

/**
 * Insert safely a tag to fix #1962 #1649
 * @param   { HTMLElement } root - children container
 * @param   { HTMLElement } curr - node to insert
 * @param   { HTMLElement } next - node that should preceed the current node inserted
 */
function safeInsert(root, curr, next) {
  root.insertBefore(curr, next.parentNode && next);
}

/**
 * Convert a style object to a string
 * @param   { Object } style - style object we need to parse
 * @returns { String } resulting css string
 * @example
 * styleObjectToString({ color: 'red', height: '10px'}) // => 'color: red; height: 10px'
 */
function styleObjectToString(style) {
  return Object.keys(style).reduce(function (acc, prop) {
    return (acc + " " + prop + ": " + (style[prop]) + ";")
  }, '')
}

/**
 * Walk down recursively all the children tags starting dom node
 * @param   { Object }   dom - starting node where we will start the recursion
 * @param   { Function } fn - callback to transform the child node just found
 * @param   { Object }   context - fn can optionally return an object, which is passed to children
 */
function walkNodes(dom, fn, context) {
  if (dom) {
    var res = fn(dom, context);
    var next;
    // stop the recursion
    if (res === false) { return }

    dom = dom.firstChild;

    while (dom) {
      next = dom.nextSibling;
      walkNodes(dom, fn, res);
      dom = next;
    }
  }
}



var dom = Object.freeze({
	$$: $$,
	$: $,
	createDOMPlaceholder: createDOMPlaceholder,
	mkEl: makeElement,
	setAttr: setAttribute,
	toggleVisibility: toggleVisibility,
	getAttr: getAttribute,
	remAttr: removeAttribute,
	setInnerHTML: setInnerHTML,
	walkAttrs: walkAttributes,
	createFrag: createFragment,
	safeInsert: safeInsert,
	styleObjectToString: styleObjectToString,
	walkNodes: walkNodes
});

/**
 * Check against the null and undefined values
 * @param   { * }  value -
 * @returns {Boolean} -
 */
function isNil(value) {
  return isUndefined(value) || value === null
}

/**
 * Check if passed argument is empty. Different from falsy, because we dont consider 0 or false to be blank
 * @param { * } value -
 * @returns { Boolean } -
 */
function isBlank(value) {
  return isNil(value) || value === ''
}

/**
 * Check if passed argument is a function
 * @param   { * } value -
 * @returns { Boolean } -
 */
function isFunction(value) {
  return typeof value === T_FUNCTION
}

/**
 * Check if passed argument is an object, exclude null
 * NOTE: use isObject(x) && !isArray(x) to excludes arrays.
 * @param   { * } value -
 * @returns { Boolean } -
 */
function isObject(value) {
  return value && typeof value === T_OBJECT // typeof null is 'object'
}

/**
 * Check if a DOM node is an svg tag or part of an svg
 * @param   { HTMLElement }  el - node we want to test
 * @returns {Boolean} true if it's an svg node
 */
function isSvg(el) {
  var owner = el.ownerSVGElement;
  return !!owner || owner === null
}

/**
 * Check if passed argument is a kind of array
 * @param   { * } value -
 * @returns { Boolean } -
 */
function isArray(value) {
  return Array.isArray(value) || value instanceof Array
}

/**
 * Check if the passed argument is a boolean attribute
 * @param   { String } value -
 * @returns { Boolean } -
 */
function isBoolAttr(value) {
  return RE_BOOL_ATTRS.test(value)
}

/**
 * Check if passed argument is a string
 * @param   { * } value -
 * @returns { Boolean } -
 */
function isString(value) {
  return typeof value === T_STRING
}



var check = Object.freeze({
	isBlank: isBlank,
	isFunction: isFunction,
	isObject: isObject,
	isSvg: isSvg,
	isWritable: isWritable,
	isArray: isArray,
	isBoolAttr: isBoolAttr,
	isNil: isNil,
	isString: isString,
	isUndefined: isUndefined
});

/**
 * Check whether an array contains an item
 * @param   { Array } array - target array
 * @param   { * } item - item to test
 * @returns { Boolean } -
 */
function contains(array, item) {
  return array.indexOf(item) !== -1
}

/**
 * Specialized function for looping an array-like collection with `each={}`
 * @param   { Array } list - collection of items
 * @param   {Function} fn - callback function
 * @returns { Array } the array looped
 */
function each(list, fn) {
  var len = list ? list.length : 0;
  var i = 0;
  for (; i < len; i++) { fn(list[i], i); }
  return list
}

/**
 * Faster String startsWith alternative
 * @param   { String } str - source string
 * @param   { String } value - test string
 * @returns { Boolean } -
 */
function startsWith(str, value) {
  return str.slice(0, value.length) === value
}

/**
 * Function returning always a unique identifier
 * @returns { Number } - number from 0...n
 */
var uid = (function uid() {
  var i = -1;
  return function () { return ++i; }
})()

/**
 * Helper function to set an immutable property
 * @param   { Object } el - object where the new property will be set
 * @param   { String } key - object key where the new property will be stored
 * @param   { * } value - value of the new property
 * @param   { Object } options - set the propery overriding the default options
 * @returns { Object } - the initial object
 */
function define(el, key, value, options) {
  Object.defineProperty(el, key, extend({
    value: value,
    enumerable: false,
    writable: false,
    configurable: true
  }, options));
  return el
}

/**
 * Convert a string containing dashes to camel case
 * @param   { String } str - input string
 * @returns { String } my-string -> myString
 */
function toCamel(str) {
  return str.replace(/-(\w)/g, function (_, c) { return c.toUpperCase(); })
}

/**
 * Warn a message via console
 * @param   {String} message - warning message
 */
function warn(message) {
  if (console && console.warn) { console.warn(message); }
}



var misc = Object.freeze({
	contains: contains,
	each: each,
	getPropDescriptor: getPropDescriptor,
	startsWith: startsWith,
	uid: uid,
	defineProperty: define,
	objectCreate: create,
	extend: extend,
	toCamel: toCamel,
	warn: warn
});

/**
 * Set the property of an object for a given key. If something already
 * exists there, then it becomes an array containing both the old and new value.
 * @param { Object } obj - object on which to set the property
 * @param { String } key - property name
 * @param { Object } value - the value of the property to be set
 * @param { Boolean } ensureArray - ensure that the property remains an array
 * @param { Number } index - add the new item in a certain array position
 */
function arrayishAdd(obj, key, value, ensureArray, index) {
  var dest = obj[key];
  var isArr = isArray(dest);
  var hasIndex = !isUndefined(index);

  if (dest && dest === value) { return }

  // if the key was never set, set it once
  if (!dest && ensureArray) { obj[key] = [value]; }
  else if (!dest) { obj[key] = value; }
  // if it was an array and not yet set
  else {
    if (isArr) {
      var oldIndex = dest.indexOf(value);
      // this item never changed its position
      if (oldIndex === index) { return }
      // remove the item from its old position
      if (oldIndex !== -1) { dest.splice(oldIndex, 1); }
      // move or add the item
      if (hasIndex) {
        dest.splice(index, 0, value);
      } else {
        dest.push(value);
      }
    } else { obj[key] = [dest, value]; }
  }
}

/**
 * Detect the tag implementation by a DOM node
 * @param   { Object } dom - DOM node we need to parse to get its tag implementation
 * @returns { Object } it returns an object containing the implementation of a custom tag (template and boot function)
 */
function get(dom) {
  return dom.tagName && __TAG_IMPL[getAttribute(dom, IS_DIRECTIVE) ||
    getAttribute(dom, IS_DIRECTIVE) || dom.tagName.toLowerCase()]
}

/**
 * Get the tag name of any DOM node
 * @param   { Object } dom - DOM node we want to parse
 * @param   { Boolean } skipDataIs - hack to ignore the data-is attribute when attaching to parent
 * @returns { String } name to identify this dom node in riot
 */
function getName(dom, skipDataIs) {
  var child = get(dom);
  var namedTag = !skipDataIs && getAttribute(dom, IS_DIRECTIVE);
  return namedTag && !tmpl.hasExpr(namedTag) ?
    namedTag : child ? child.name : dom.tagName.toLowerCase()
}

/**
 * Return a temporary context containing also the parent properties
 * @this Tag
 * @param { Tag } - temporary tag context containing all the parent properties
 */
function inheritParentProps() {
  if (this.parent) { return extend(create(this), this.parent) }
  return this
}

/*
  Includes hacks needed for the Internet Explorer version 9 and below
  See: http://kangax.github.io/compat-table/es5/#ie8
       http://codeplanet.io/dropping-ie8/
*/

var
  reHasYield  = /<yield\b/i,
  reYieldAll  = /<yield\s*(?:\/>|>([\S\s]*?)<\/yield\s*>|>)/ig,
  reYieldSrc  = /<yield\s+to=['"]([^'">]*)['"]\s*>([\S\s]*?)<\/yield\s*>/ig,
  reYieldDest = /<yield\s+from=['"]?([-\w]+)['"]?\s*(?:\/>|>([\S\s]*?)<\/yield\s*>)/ig,
  rootEls = { tr: 'tbody', th: 'tr', td: 'tr', col: 'colgroup' },
  tblTags = IE_VERSION && IE_VERSION < 10 ? RE_SPECIAL_TAGS : RE_SPECIAL_TAGS_NO_OPTION,
  GENERIC = 'div',
  SVG = 'svg';;;;;;;;


/*
  Creates the root element for table or select child elements:
  tr/th/td/thead/tfoot/tbody/caption/col/colgroup/option/optgroup
*/
function specialTags(el, tmpl, tagName) {

  var
    select = tagName[0] === 'o',
    parent = select ? 'select>' : 'table>';;

  // trim() is important here, this ensures we don't have artifacts,
  // so we can check if we have only one element inside the parent
  el.innerHTML = '<' + parent + tmpl.trim() + '</' + parent;
  parent = el.firstChild;

  // returns the immediate parent if tr/th/td/col is the only element, if not
  // returns the whole tree, as this can include additional elements
  /* istanbul ignore next */
  if (select) {
    parent.selectedIndex = -1;  // for IE9, compatible w/current riot behavior
  } else {
    // avoids insertion of cointainer inside container (ex: tbody inside tbody)
    var tname = rootEls[tagName];
    if (tname && parent.childElementCount === 1) { parent = $(tname, parent); }
  }
  return parent
}

/*
  Replace the yield tag from any tag template with the innerHTML of the
  original tag in the page
*/
function replaceYield(tmpl, html) {
  // do nothing if no yield
  if (!reHasYield.test(tmpl)) { return tmpl }

  // be careful with #1343 - string on the source having `$1`
  var src = {};

  html = html && html.replace(reYieldSrc, function (_, ref, text) {
    src[ref] = src[ref] || text;   // preserve first definition
    return ''
  }).trim();

  return tmpl
    .replace(reYieldDest, function (_, ref, def) {  // yield with from - to attrs
      return src[ref] || def || ''
    })
    .replace(reYieldAll, function (_, def) {        // yield without any "from"
      return html || def || ''
    })
}

/**
 * Creates a DOM element to wrap the given content. Normally an `DIV`, but can be
 * also a `TABLE`, `SELECT`, `TBODY`, `TR`, or `COLGROUP` element.
 *
 * @param   { String } tmpl  - The template coming from the custom tag definition
 * @param   { String } html - HTML content that comes from the DOM element where you
 *           will mount the tag, mostly the original tag in the page
 * @param   { Boolean } isSvg - true if the root node is an svg
 * @returns { HTMLElement } DOM element with _tmpl_ merged through `YIELD` with the _html_.
 */
function mkdom(tmpl, html, isSvg) {
  var match   = tmpl && tmpl.match(/^\s*<([-\w]+)/);
  var  tagName = match && match[1].toLowerCase();
  var el = makeElement(isSvg ? SVG : GENERIC);

  // replace all the yield tags with the tag inner html
  tmpl = replaceYield(tmpl, html);

  /* istanbul ignore next */
  if (tblTags.test(tagName))
    { el = specialTags(el, tmpl, tagName); }
  else
    { setInnerHTML(el, tmpl, isSvg); }

  return el
}

/**
 * Loop backward all the parents tree to detect the first custom parent tag
 * @param   { Object } tag - a Tag instance
 * @returns { Object } the instance of the first custom parent tag found
 */
function getImmediateCustomParent(tag) {
  var ptag = tag;
  while (ptag.__.isAnonymous) {
    if (!ptag.parent) { break }
    ptag = ptag.parent;
  }
  return ptag
}

/**
 * Trigger DOM events
 * @param   { HTMLElement } dom - dom element target of the event
 * @param   { Function } handler - user function
 * @param   { Object } e - event object
 */
function handleEvent(dom, handler, e) {
  var ptag = this.__.parent;
  var item = this.__.item;

  if (!item)
    { while (ptag && !item) {
      item = ptag.__.item;
      ptag = ptag.__.parent;
    } }

  // override the event properties
  /* istanbul ignore next */
  if (isWritable(e, 'currentTarget')) { e.currentTarget = dom; }
  /* istanbul ignore next */
  if (isWritable(e, 'target')) { e.target = e.srcElement; }
  /* istanbul ignore next */
  if (isWritable(e, 'which')) { e.which = e.charCode || e.keyCode; }

  e.item = item;

  handler.call(this, e);

  // avoid auto updates
  if (!settings.autoUpdate) { return }

  if (!e.preventUpdate) {
    var p = getImmediateCustomParent(this);
    // fixes #2083
    if (p.isMounted) { p.update(); }
  }
}

/**
 * Attach an event to a DOM node
 * @param { String } name - event name
 * @param { Function } handler - event callback
 * @param { Object } dom - dom node
 * @param { Tag } tag - tag instance
 */
function setEventHandler(name, handler, dom, tag) {
  var eventName;
  var cb = handleEvent.bind(tag, dom, handler);

  // avoid to bind twice the same event
  // possible fix for #2332
  dom[name] = null;

  // normalize event name
  eventName = name.replace(RE_EVENTS_PREFIX, '');

  // cache the listener into the listeners array
  if (!contains(tag.__.listeners, dom)) { tag.__.listeners.push(dom); }
  if (!dom[RIOT_EVENTS_KEY]) { dom[RIOT_EVENTS_KEY] = {}; }
  if (dom[RIOT_EVENTS_KEY][name]) { dom.removeEventListener(eventName, dom[RIOT_EVENTS_KEY][name]); }

  dom[RIOT_EVENTS_KEY][name] = cb;
  dom.addEventListener(eventName, cb, false);
}

/**
 * Create a new child tag including it correctly into its parent
 * @param   { Object } child - child tag implementation
 * @param   { Object } opts - tag options containing the DOM node where the tag will be mounted
 * @param   { String } innerHTML - inner html of the child node
 * @param   { Object } parent - instance of the parent tag including the child custom tag
 * @returns { Object } instance of the new child tag just created
 */
function initChild(child, opts, innerHTML, parent) {
  var tag = createTag(child, opts, innerHTML);
  var tagName = opts.tagName || getName(opts.root, true);
  var ptag = getImmediateCustomParent(parent);
  // fix for the parent attribute in the looped elements
  define(tag, 'parent', ptag);
  // store the real parent tag
  // in some cases this could be different from the custom parent tag
  // for example in nested loops
  tag.__.parent = parent;

  // add this tag to the custom parent tag
  arrayishAdd(ptag.tags, tagName, tag);

  // and also to the real parent tag
  if (ptag !== parent)
    { arrayishAdd(parent.tags, tagName, tag); }

  return tag
}

/**
 * Removes an item from an object at a given key. If the key points to an array,
 * then the item is just removed from the array.
 * @param { Object } obj - object on which to remove the property
 * @param { String } key - property name
 * @param { Object } value - the value of the property to be removed
 * @param { Boolean } ensureArray - ensure that the property remains an array
*/
function arrayishRemove(obj, key, value, ensureArray) {
  if (isArray(obj[key])) {
    var index = obj[key].indexOf(value);
    if (index !== -1) { obj[key].splice(index, 1); }
    if (!obj[key].length) { delete obj[key]; }
    else if (obj[key].length === 1 && !ensureArray) { obj[key] = obj[key][0]; }
  } else if (obj[key] === value)
    { delete obj[key]; } // otherwise just delete the key
}

/**
 * Adds the elements for a virtual tag
 * @this Tag
 * @param { Node } src - the node that will do the inserting or appending
 * @param { Tag } target - only if inserting, insert before this tag's first child
 */
function makeVirtual(src, target) {
  var this$1 = this;

  var head = createDOMPlaceholder();
  var tail = createDOMPlaceholder();
  var frag = createFragment();
  var sib;
  var el;

  this.root.insertBefore(head, this.root.firstChild);
  this.root.appendChild(tail);

  this.__.head = el = head;
  this.__.tail = tail;

  while (el) {
    sib = el.nextSibling;
    frag.appendChild(el);
    this$1.__.virts.push(el); // hold for unmounting
    el = sib;
  }

  if (target)
    { src.insertBefore(frag, target.__.head); }
  else
    { src.appendChild(frag); }
}

/**
 * makes a tag virtual and replaces a reference in the dom
 * @this Tag
 * @param { tag } the tag to make virtual
 * @param { ref } the dom reference location
 */
function makeReplaceVirtual(tag, ref) {
  var frag = createFragment();
  makeVirtual.call(tag, frag);
  ref.parentNode.replaceChild(frag, ref);
}

/**
 * Update dynamically created data-is tags with changing expressions
 * @param { Object } expr - expression tag and expression info
 * @param { Tag }    parent - parent for tag creation
 * @param { String } tagName - tag implementation we want to use
 */
function updateDataIs(expr, parent, tagName) {
  var tag = expr.tag || expr.dom._tag;
  var ref;

  var ref$1 = tag ? tag.__ : {};
  var head = ref$1.head;
  var isVirtual = expr.dom.tagName === 'VIRTUAL';

  if (tag && expr.tagName === tagName) {
    tag.update();
    return
  }

  // sync _parent to accommodate changing tagnames
  if (tag) {
    // need placeholder before unmount
    if(isVirtual) {
      ref = createDOMPlaceholder();
      head.parentNode.insertBefore(ref, head);
    }

    tag.unmount(true);
  }

  // unable to get the tag name
  if (!isString(tagName)) { return }

  expr.impl = __TAG_IMPL[tagName];

  // unknown implementation
  if (!expr.impl) { return }

  expr.tag = tag = initChild(
    expr.impl, {
      root: expr.dom,
      parent: parent,
      tagName: tagName
    },
    expr.dom.innerHTML,
    parent
  );

  each(expr.attrs, function (a) { return setAttribute(tag.root, a.name, a.value); });
  expr.tagName = tagName;
  tag.mount();

  // root exist first time, after use placeholder
  if (isVirtual) { makeReplaceVirtual(tag, ref || tag.root); }

  // parent is the placeholder tag, not the dynamic tag so clean up
  parent.__.onUnmount = function () {
    var delName = tag.opts.dataIs;
    arrayishRemove(tag.parent.tags, delName, tag);
    arrayishRemove(tag.__.parent.tags, delName, tag);
    tag.unmount();
  };
}

/**
 * Nomalize any attribute removing the "riot-" prefix
 * @param   { String } attrName - original attribute name
 * @returns { String } valid html attribute name
 */
function normalizeAttrName(attrName) {
  if (!attrName) { return null }
  attrName = attrName.replace(ATTRS_PREFIX, '');
  if (CASE_SENSITIVE_ATTRIBUTES[attrName]) { attrName = CASE_SENSITIVE_ATTRIBUTES[attrName]; }
  return attrName
}

/**
 * Update on single tag expression
 * @this Tag
 * @param { Object } expr - expression logic
 * @returns { undefined }
 */
function updateExpression(expr) {
  if (this.root && getAttribute(this.root,'virtualized')) { return }

  var dom = expr.dom;
  // remove the riot- prefix
  var attrName = normalizeAttrName(expr.attr);
  var isToggle = contains([SHOW_DIRECTIVE, HIDE_DIRECTIVE], attrName);
  var isVirtual = expr.root && expr.root.tagName === 'VIRTUAL';
  var ref = this.__;
  var isAnonymous = ref.isAnonymous;
  var parent = dom && (expr.parent || dom.parentNode);
  // detect the style attributes
  var isStyleAttr = attrName === 'style';
  var isClassAttr = attrName === 'class';

  var value;

  // if it's a tag we could totally skip the rest
  if (expr._riot_id) {
    if (expr.__.wasCreated) {
      expr.update();
    // if it hasn't been mounted yet, do that now.
    } else {
      expr.mount();
      if (isVirtual) {
        makeReplaceVirtual(expr, expr.root);
      }
    }
    return
  }

  // if this expression has the update method it means it can handle the DOM changes by itself
  if (expr.update) { return expr.update() }

  var context = isToggle && !isAnonymous ? inheritParentProps.call(this) : this;

  // ...it seems to be a simple expression so we try to calculate its value
  value = tmpl(expr.expr, context);

  var hasValue = !isBlank(value);
  var isObj = isObject(value);

  // convert the style/class objects to strings
  if (isObj) {
    if (isClassAttr) {
      value = tmpl(JSON.stringify(value), this);
    } else if (isStyleAttr) {
      value = styleObjectToString(value);
    }
  }

  // remove original attribute
  if (expr.attr && (!expr.wasParsedOnce || !hasValue || value === false)) {
    // remove either riot-* attributes or just the attribute name
    removeAttribute(dom, getAttribute(dom, expr.attr) ? expr.attr : attrName);
  }

  // for the boolean attributes we don't need the value
  // we can convert it to checked=true to checked=checked
  if (expr.bool) { value = value ? attrName : false; }
  if (expr.isRtag) { return updateDataIs(expr, this, value) }
  if (expr.wasParsedOnce && expr.value === value) { return }

  // update the expression value
  expr.value = value;
  expr.wasParsedOnce = true;

  // if the value is an object (and it's not a style or class attribute) we can not do much more with it
  if (isObj && !isClassAttr && !isStyleAttr && !isToggle) { return }
  // avoid to render undefined/null values
  if (!hasValue) { value = ''; }

  // textarea and text nodes have no attribute name
  if (!attrName) {
    // about #815 w/o replace: the browser converts the value to a string,
    // the comparison by "==" does too, but not in the server
    value += '';
    // test for parent avoids error with invalid assignment to nodeValue
    if (parent) {
      // cache the parent node because somehow it will become null on IE
      // on the next iteration
      expr.parent = parent;
      if (parent.tagName === 'TEXTAREA') {
        parent.value = value;                    // #1113
        if (!IE_VERSION) { dom.nodeValue = value; }  // #1625 IE throws here, nodeValue
      }                                         // will be available on 'updated'
      else { dom.nodeValue = value; }
    }
    return
  }


  // event handler
  if (isFunction(value)) {
    setEventHandler(attrName, value, dom, this);
  // show / hide
  } else if (isToggle) {
    toggleVisibility(dom, attrName === HIDE_DIRECTIVE ? !value : value);
  // handle attributes
  } else {
    if (expr.bool) {
      dom[attrName] = value;
    }

    if (attrName === 'value' && dom.value !== value) {
      dom.value = value;
    } else if (hasValue && value !== false) {
      setAttribute(dom, attrName, value);
    }

    // make sure that in case of style changes
    // the element stays hidden
    if (isStyleAttr && dom.hidden) { toggleVisibility(dom, false); }
  }
}

/**
 * Update all the expressions in a Tag instance
 * @this Tag
 * @param { Array } expressions - expression that must be re evaluated
 */
function update(expressions) {
  each(expressions, updateExpression.bind(this));
}

/**
 * We need to update opts for this tag. That requires updating the expressions
 * in any attributes on the tag, and then copying the result onto opts.
 * @this Tag
 * @param   {Boolean} isLoop - is it a loop tag?
 * @param   { Tag }  parent - parent tag node
 * @param   { Boolean }  isAnonymous - is it a tag without any impl? (a tag not registered)
 * @param   { Object }  opts - tag options
 * @param   { Array }  instAttrs - tag attributes array
 */
function updateOpts(isLoop, parent, isAnonymous, opts, instAttrs) {
  // isAnonymous `each` tags treat `dom` and `root` differently. In this case
  // (and only this case) we don't need to do updateOpts, because the regular parse
  // will update those attrs. Plus, isAnonymous tags don't need opts anyway
  if (isLoop && isAnonymous) { return }
  var ctx = isLoop ? inheritParentProps.call(this) : parent || this;

  each(instAttrs, function (attr) {
    if (attr.expr) { updateExpression.call(ctx, attr.expr); }
    // normalize the attribute names
    opts[toCamel(attr.name).replace(ATTRS_PREFIX, '')] = attr.expr ? attr.expr.value : attr.value;
  });
}

/**
 * Update the tag expressions and options
 * @param { Tag } tag - tag object
 * @param { * } data - data we want to use to extend the tag properties
 * @param { Array } expressions - component expressions array
 * @returns { Tag } the current tag instance
 */
function componentUpdate(tag, data, expressions) {
  var __ = tag.__;
  var nextOpts = {};
  var canTrigger = tag.isMounted && !__.skipAnonymous;

  // inherit properties from the parent tag
  if (__.isAnonymous && __.parent) { extend(tag, __.parent); }
  extend(tag, data);

  updateOpts.apply(tag, [__.isLoop, __.parent, __.isAnonymous, nextOpts, __.instAttrs]);

  if (
    canTrigger &&
    tag.isMounted &&
    isFunction(tag.shouldUpdate) && !tag.shouldUpdate(data, nextOpts)
  ) {
    return tag
  }

  extend(tag.opts, nextOpts);

  if (canTrigger) { tag.trigger('update', data); }
  update.call(tag, expressions);
  if (canTrigger) { tag.trigger('updated'); }

  return tag
}

/**
 * Get selectors for tags
 * @param   { Array } tags - tag names to select
 * @returns { String } selector
 */
function query(tags) {
  // select all tags
  if (!tags) {
    var keys = Object.keys(__TAG_IMPL);
    return keys + query(keys)
  }

  return tags
    .filter(function (t) { return !/[^-\w]/.test(t); })
    .reduce(function (list, t) {
      var name = t.trim().toLowerCase();
      return list + ",[" + IS_DIRECTIVE + "=\"" + name + "\"]"
    }, '')
}

/**
 * Another way to create a riot tag a bit more es6 friendly
 * @param { HTMLElement } el - tag DOM selector or DOM node/s
 * @param { Object } opts - tag logic
 * @returns { Tag } new riot tag instance
 */
function Tag(el, opts) {
  // get the tag properties from the class constructor
  var ref = this;
  var name = ref.name;
  var tmpl = ref.tmpl;
  var css = ref.css;
  var attrs = ref.attrs;
  var onCreate = ref.onCreate;
  // register a new tag and cache the class prototype
  if (!__TAG_IMPL[name]) {
    tag(name, tmpl, css, attrs, onCreate);
    // cache the class constructor
    __TAG_IMPL[name].class = this.constructor;
  }

  // mount the tag using the class instance
  mount$1(el, name, opts, this);
  // inject the component css
  if (css) { styleManager.inject(); }

  return this
}

/**
 * Create a new riot tag implementation
 * @param   { String }   name - name/id of the new riot tag
 * @param   { String }   tmpl - tag template
 * @param   { String }   css - custom tag css
 * @param   { String }   attrs - root tag attributes
 * @param   { Function } fn - user function
 * @returns { String } name/id of the tag just created
 */
function tag(name, tmpl, css, attrs, fn) {
  if (isFunction(attrs)) {
    fn = attrs;

    if (/^[\w-]+\s?=/.test(css)) {
      attrs = css;
      css = '';
    } else
      { attrs = ''; }
  }

  if (css) {
    if (isFunction(css))
      { fn = css; }
    else
      { styleManager.add(css); }
  }

  name = name.toLowerCase();
  __TAG_IMPL[name] = { name: name, tmpl: tmpl, attrs: attrs, fn: fn };

  return name
}

/**
 * Create a new riot tag implementation (for use by the compiler)
 * @param   { String }   name - name/id of the new riot tag
 * @param   { String }   tmpl - tag template
 * @param   { String }   css - custom tag css
 * @param   { String }   attrs - root tag attributes
 * @param   { Function } fn - user function
 * @returns { String } name/id of the tag just created
 */
function tag2(name, tmpl, css, attrs, fn) {
  if (css) { styleManager.add(css, name); }

  __TAG_IMPL[name] = { name: name, tmpl: tmpl, attrs: attrs, fn: fn };

  return name
}

/**
 * Mount a tag using a specific tag implementation
 * @param   { * } selector - tag DOM selector or DOM node/s
 * @param   { String } tagName - tag implementation name
 * @param   { Object } opts - tag logic
 * @returns { Array } new tags instances
 */
function mount(selector, tagName, opts) {
  var tags = [];
  var elem, allTags;;

  function pushTagsTo(root) {
    if (root.tagName) {
      var riotTag = getAttribute(root, IS_DIRECTIVE), tag;;

      // have tagName? force riot-tag to be the same
      if (tagName && riotTag !== tagName) {
        riotTag = tagName;
        setAttribute(root, IS_DIRECTIVE, tagName);
      }

      tag = mount$1(root, riotTag || root.tagName.toLowerCase(), opts);

      if (tag)
        { tags.push(tag); }
    } else if (root.length)
      { each(root, pushTagsTo); } // assume nodeList
  }

  // inject styles into DOM
  styleManager.inject();

  if (isObject(tagName)) {
    opts = tagName;
    tagName = 0;
  }

  // crawl the DOM to find the tag
  if (isString(selector)) {
    selector = selector === '*' ?
      // select all registered tags
      // & tags found with the riot-tag attribute set
      allTags = query() :
      // or just the ones named like the selector
      selector + query(selector.split(/, */));

    // make sure to pass always a selector
    // to the querySelectorAll function
    elem = selector ? $$(selector) : [];
  }
  else
    // probably you have passed already a tag or a NodeList
    { elem = selector; }

  // select all the registered and mount them inside their root elements
  if (tagName === '*') {
    // get all custom tags
    tagName = allTags || query();
    // if the root els it's just a single tag
    if (elem.tagName)
      { elem = $$(tagName, elem); }
    else {
      // select all the children for all the different root elements
      var nodeList = [];

      each(elem, function (_el) { return nodeList.push($$(tagName, _el)); });

      elem = nodeList;
    }
    // get rid of the tagName
    tagName = 0;
  }

  pushTagsTo(elem);

  return tags
}

// Create a mixin that could be globally shared across all the tags
var mixins = {};
var globals = mixins[GLOBAL_MIXIN] = {};
var mixins_id = 0;

/**
 * Create/Return a mixin by its name
 * @param   { String }  name - mixin name (global mixin if object)
 * @param   { Object }  mix - mixin logic
 * @param   { Boolean } g - is global?
 * @returns { Object }  the mixin logic
 */
function mixin(name, mix, g) {
  // Unnamed global
  if (isObject(name)) {
    mixin(("__" + (mixins_id++) + "__"), name, true);
    return
  }

  var store = g ? globals : mixins;

  // Getter
  if (!mix) {
    if (isUndefined(store[name]))
      { throw new Error(("Unregistered mixin: " + name)) }

    return store[name]
  }

  // Setter
  store[name] = isFunction(mix) ?
    extend(mix.prototype, store[name] || {}) && mix :
    extend(store[name] || {}, mix);
}

/**
 * Update all the tags instances created
 * @returns { Array } all the tags instances
 */
function update$1() {
  return each(__TAGS_CACHE, function (tag) { return tag.update(); })
}

function unregister(name) {
  __TAG_IMPL[name] = null;
}

var version = 'v3.9.0';


var core = Object.freeze({
	Tag: Tag,
	tag: tag,
	tag2: tag2,
	mount: mount,
	mixin: mixin,
	update: update$1,
	unregister: unregister,
	version: version
});

/**
 * Add a mixin to this tag
 * @returns { Tag } the current tag instance
 */
function componentMixin(tag$$1) {
  var mixins = [], len = arguments.length - 1;
  while ( len-- > 0 ) mixins[ len ] = arguments[ len + 1 ];

  each(mixins, function (mix) {
    var instance;
    var obj;
    var props = [];

    // properties blacklisted and will not be bound to the tag instance
    var propsBlacklist = ['init', '__proto__'];

    mix = isString(mix) ? mixin(mix) : mix;

    // check if the mixin is a function
    if (isFunction(mix)) {
      // create the new mixin instance
      instance = new mix();
    } else { instance = mix; }

    var proto = Object.getPrototypeOf(instance);

    // build multilevel prototype inheritance chain property list
    do { props = props.concat(Object.getOwnPropertyNames(obj || instance)); }
    while (obj = Object.getPrototypeOf(obj || instance))

    // loop the keys in the function prototype or the all object keys
    each(props, function (key) {
      // bind methods to tag
      // allow mixins to override other properties/parent mixins
      if (!contains(propsBlacklist, key)) {
        // check for getters/setters
        var descriptor = getPropDescriptor(instance, key) || getPropDescriptor(proto, key);
        var hasGetterSetter = descriptor && (descriptor.get || descriptor.set);

        // apply method only if it does not already exist on the instance
        if (!tag$$1.hasOwnProperty(key) && hasGetterSetter) {
          Object.defineProperty(tag$$1, key, descriptor);
        } else {
          tag$$1[key] = isFunction(instance[key]) ?
            instance[key].bind(tag$$1) :
            instance[key];
        }
      }
    });

    // init method will be called automatically
    if (instance.init)
      { instance.init.bind(tag$$1)(tag$$1.opts); }
  });

  return tag$$1
}

/**
 * Move the position of a custom tag in its parent tag
 * @this Tag
 * @param   { String } tagName - key where the tag was stored
 * @param   { Number } newPos - index where the new tag will be stored
 */
function moveChild(tagName, newPos) {
  var parent = this.parent;
  var tags;
  // no parent no move
  if (!parent) { return }

  tags = parent.tags[tagName];

  if (isArray(tags))
    { tags.splice(newPos, 0, tags.splice(tags.indexOf(this), 1)[0]); }
  else { arrayishAdd(parent.tags, tagName, this); }
}

/**
 * Move virtual tag and all child nodes
 * @this Tag
 * @param { Node } src  - the node that will do the inserting
 * @param { Tag } target - insert before this tag's first child
 */
function moveVirtual(src, target) {
  var this$1 = this;

  var el = this.__.head;
  var sib;
  var frag = createFragment();

  while (el) {
    sib = el.nextSibling;
    frag.appendChild(el);
    el = sib;
    if (el === this$1.__.tail) {
      frag.appendChild(el);
      src.insertBefore(frag, target.__.head);
      break
    }
  }
}

/**
 * Convert the item looped into an object used to extend the child tag properties
 * @param   { Object } expr - object containing the keys used to extend the children tags
 * @param   { * } key - value to assign to the new object returned
 * @param   { * } val - value containing the position of the item in the array
 * @param   { Object } base - prototype object for the new item
 * @returns { Object } - new object containing the values of the original item
 *
 * The variables 'key' and 'val' are arbitrary.
 * They depend on the collection type looped (Array, Object)
 * and on the expression used on the each tag
 *
 */
function mkitem(expr, key, val, base) {
  var item = base ? create(base) : {};
  item[expr.key] = key;
  if (expr.pos) { item[expr.pos] = val; }
  return item
}

/**
 * Unmount the redundant tags
 * @param   { Array } items - array containing the current items to loop
 * @param   { Array } tags - array containing all the children tags
 */
function unmountRedundant(items, tags) {
  var i = tags.length;
  var j = items.length;

  while (i > j) {
    i--;
    remove.apply(tags[i], [tags, i]);
  }
}


/**
 * Remove a child tag
 * @this Tag
 * @param   { Array } tags - tags collection
 * @param   { Number } i - index of the tag to remove
 */
function remove(tags, i) {
  tags.splice(i, 1);
  this.unmount();
  arrayishRemove(this.parent, this, this.__.tagName, true);
}

/**
 * Move the nested custom tags in non custom loop tags
 * @this Tag
 * @param   { Number } i - current position of the loop tag
 */
function moveNestedTags(i) {
  var this$1 = this;

  each(Object.keys(this.tags), function (tagName) {
    moveChild.apply(this$1.tags[tagName], [tagName, i]);
  });
}

/**
 * Move a child tag
 * @this Tag
 * @param   { HTMLElement } root - dom node containing all the loop children
 * @param   { Tag } nextTag - instance of the next tag preceding the one we want to move
 * @param   { Boolean } isVirtual - is it a virtual tag?
 */
function move(root, nextTag, isVirtual) {
  if (isVirtual)
    { moveVirtual.apply(this, [root, nextTag]); }
  else
    { safeInsert(root, this.root, nextTag.root); }
}

/**
 * Insert and mount a child tag
 * @this Tag
 * @param   { HTMLElement } root - dom node containing all the loop children
 * @param   { Tag } nextTag - instance of the next tag preceding the one we want to insert
 * @param   { Boolean } isVirtual - is it a virtual tag?
 */
function insert(root, nextTag, isVirtual) {
  if (isVirtual)
    { makeVirtual.apply(this, [root, nextTag]); }
  else
    { safeInsert(root, this.root, nextTag.root); }
}

/**
 * Append a new tag into the DOM
 * @this Tag
 * @param   { HTMLElement } root - dom node containing all the loop children
 * @param   { Boolean } isVirtual - is it a virtual tag?
 */
function append(root, isVirtual) {
  if (isVirtual)
    { makeVirtual.call(this, root); }
  else
    { root.appendChild(this.root); }
}

/**
 * Return the value we want to use to lookup the postion of our items in the collection
 * @param   { String }  keyAttr         - lookup string or expression
 * @param   { * }       originalItem    - original item from the collection
 * @param   { Object }  keyedItem       - object created by riot via { item, i in collection }
 * @param   { Boolean } hasKeyAttrExpr  - flag to check whether the key is an expression
 * @returns { * } value that we will use to figure out the item position via collection.indexOf
 */
function getItemId(keyAttr, originalItem, keyedItem, hasKeyAttrExpr) {
  if (keyAttr) {
    return hasKeyAttrExpr ?  tmpl(keyAttr, keyedItem) :  originalItem[keyAttr]
  }

  return originalItem
}

/**
 * Manage tags having the 'each'
 * @param   { HTMLElement } dom - DOM node we need to loop
 * @param   { Tag } parent - parent tag instance where the dom node is contained
 * @param   { String } expr - string contained in the 'each' attribute
 * @returns { Object } expression object for this each loop
 */
function _each(dom, parent, expr) {
  var mustReorder = typeof getAttribute(dom, LOOP_NO_REORDER_DIRECTIVE) !== T_STRING || removeAttribute(dom, LOOP_NO_REORDER_DIRECTIVE);
  var keyAttr = getAttribute(dom, KEY_DIRECTIVE);
  var hasKeyAttrExpr = keyAttr ? tmpl.hasExpr(keyAttr) : false;
  var tagName = getName(dom);
  var impl = __TAG_IMPL[tagName];
  var parentNode = dom.parentNode;
  var placeholder = createDOMPlaceholder();
  var child = get(dom);
  var ifExpr = getAttribute(dom, CONDITIONAL_DIRECTIVE);
  var tags = [];
  var isLoop = true;
  var innerHTML = dom.innerHTML;
  var isAnonymous = !__TAG_IMPL[tagName];
  var isVirtual = dom.tagName === 'VIRTUAL';
  var oldItems = [];
  var hasKeys;

  // remove the each property from the original tag
  removeAttribute(dom, LOOP_DIRECTIVE);
  removeAttribute(dom, KEY_DIRECTIVE);

  // parse the each expression
  expr = tmpl.loopKeys(expr);
  expr.isLoop = true;

  if (ifExpr) { removeAttribute(dom, CONDITIONAL_DIRECTIVE); }

  // insert a marked where the loop tags will be injected
  parentNode.insertBefore(placeholder, dom);
  parentNode.removeChild(dom);

  expr.update = function updateEach() {
    // get the new items collection
    expr.value = tmpl(expr.val, parent);

    var items = expr.value;
    var frag = createFragment();
    var isObject = !isArray(items) && !isString(items);
    var root = placeholder.parentNode;
    var tmpItems = [];

    // if this DOM was removed the update here is useless
    // this condition fixes also a weird async issue on IE in our unit test
    if (!root) { return }

    // object loop. any changes cause full redraw
    if (isObject) {
      hasKeys = items || false;
      items = hasKeys ?
        Object.keys(items).map(function (key) { return mkitem(expr, items[key], key); }) : [];
    } else {
      hasKeys = false;
    }

    if (ifExpr) {
      items = items.filter(function (item, i) {
        if (expr.key && !isObject)
          { return !!tmpl(ifExpr, mkitem(expr, item, i, parent)) }

        return !!tmpl(ifExpr, extend(create(parent), item))
      });
    }

    // loop all the new items
    each(items, function (_item, i) {
      var item = !hasKeys && expr.key ? mkitem(expr, _item, i) : _item;
      var itemId = getItemId(keyAttr, _item, item, hasKeyAttrExpr);
      // reorder only if the items are objects
      var doReorder = mustReorder && typeof _item === T_OBJECT && !hasKeys;
      var oldPos = oldItems.indexOf(itemId);
      var isNew = oldPos === -1;
      var pos = !isNew && doReorder ? oldPos : i;
      // does a tag exist in this position?
      var tag = tags[pos];
      var mustAppend = i >= oldItems.length;
      var mustCreate =  doReorder && isNew || !doReorder && !tag;

      // new tag
      if (mustCreate) {
        tag = createTag(impl, {
          parent: parent,
          isLoop: isLoop,
          isAnonymous: isAnonymous,
          tagName: tagName,
          root: dom.cloneNode(isAnonymous),
          item: item,
          index: i,
        }, innerHTML);

        // mount the tag
        tag.mount();

        if (mustAppend)
          { append.apply(tag, [frag || root, isVirtual]); }
        else
          { insert.apply(tag, [root, tags[i], isVirtual]); }

        if (!mustAppend) { oldItems.splice(i, 0, item); }
        tags.splice(i, 0, tag);
        if (child) { arrayishAdd(parent.tags, tagName, tag, true); }
      } else if (pos !== i && doReorder) {
        // move
        if (keyAttr || contains(items, oldItems[pos])) {
          move.apply(tag, [root, tags[i], isVirtual]);
          // move the old tag instance
          tags.splice(i, 0, tags.splice(pos, 1)[0]);
          // move the old item
          oldItems.splice(i, 0, oldItems.splice(pos, 1)[0]);
        }

        // update the position attribute if it exists
        if (expr.pos) { tag[expr.pos] = i; }

        // if the loop tags are not custom
        // we need to move all their custom tags into the right position
        if (!child && tag.tags) { moveNestedTags.call(tag, i); }
      }

      // cache the original item to use it in the events bound to this node
      // and its children
      extend(tag.__, {
        item: item,
        index: i,
        parent: parent
      });

      tmpItems[i] = itemId;

      if (!mustCreate) { tag.update(item); }
    });

    // remove the redundant tags
    unmountRedundant(items, tags);

    // clone the items array
    oldItems = tmpItems.slice();

    root.insertBefore(frag, placeholder);
  };

  expr.unmount = function () {
    each(tags, function (t) { t.unmount(); });
  };

  return expr
}

var RefExpr = {
  init: function init(dom, parent, attrName, attrValue) {
    this.dom = dom;
    this.attr = attrName;
    this.rawValue = attrValue;
    this.parent = parent;
    this.hasExp = tmpl.hasExpr(attrValue);
    return this
  },
  update: function update() {
    var old = this.value;
    var customParent = this.parent && getImmediateCustomParent(this.parent);
    // if the referenced element is a custom tag, then we set the tag itself, rather than DOM
    var tagOrDom = this.dom.__ref || this.tag || this.dom;

    this.value = this.hasExp ? tmpl(this.rawValue, this.parent) : this.rawValue;

    // the name changed, so we need to remove it from the old key (if present)
    if (!isBlank(old) && customParent) { arrayishRemove(customParent.refs, old, tagOrDom); }
    if (!isBlank(this.value) && isString(this.value)) {
      // add it to the refs of parent tag (this behavior was changed >=3.0)
      if (customParent) { arrayishAdd(
        customParent.refs,
        this.value,
        tagOrDom,
        // use an array if it's a looped node and the ref is not an expression
        null,
        this.parent.__.index
      ); }

      if (this.value !== old) {
        setAttribute(this.dom, this.attr, this.value);
      }
    } else {
      removeAttribute(this.dom, this.attr);
    }

    // cache the ref bound to this dom node
    // to reuse it in future (see also #2329)
    if (!this.dom.__ref) { this.dom.__ref = tagOrDom; }
  },
  unmount: function unmount() {
    var tagOrDom = this.tag || this.dom;
    var customParent = this.parent && getImmediateCustomParent(this.parent);
    if (!isBlank(this.value) && customParent)
      { arrayishRemove(customParent.refs, this.value, tagOrDom); }
  }
}

/**
 * Create a new ref directive
 * @param   { HTMLElement } dom - dom node having the ref attribute
 * @param   { Tag } context - tag instance where the DOM node is located
 * @param   { String } attrName - either 'ref' or 'data-ref'
 * @param   { String } attrValue - value of the ref attribute
 * @returns { RefExpr } a new RefExpr object
 */
function createRefDirective(dom, tag, attrName, attrValue) {
  return create(RefExpr).init(dom, tag, attrName, attrValue)
}

/**
 * Trigger the unmount method on all the expressions
 * @param   { Array } expressions - DOM expressions
 */
function unmountAll(expressions) {
  each(expressions, function (expr) {
    if (expr.unmount) { expr.unmount(true); }
    else if (expr.tagName) { expr.tag.unmount(true); }
    else if (expr.unmount) { expr.unmount(); }
  });
}

var IfExpr = {
  init: function init(dom, tag, expr) {
    removeAttribute(dom, CONDITIONAL_DIRECTIVE);
    extend(this, { tag: tag, expr: expr, stub: createDOMPlaceholder(), pristine: dom });
    var p = dom.parentNode;
    p.insertBefore(this.stub, dom);
    p.removeChild(dom);

    return this
  },
  update: function update$$1() {
    this.value = tmpl(this.expr, this.tag);

    if (this.value && !this.current) { // insert
      this.current = this.pristine.cloneNode(true);
      this.stub.parentNode.insertBefore(this.current, this.stub);
      this.expressions = parseExpressions.apply(this.tag, [this.current, true]);
    } else if (!this.value && this.current) { // remove
      unmountAll(this.expressions);
      if (this.current._tag) {
        this.current._tag.unmount();
      } else if (this.current.parentNode) {
        this.current.parentNode.removeChild(this.current);
      }
      this.current = null;
      this.expressions = [];
    }

    if (this.value) { update.call(this.tag, this.expressions); }
  },
  unmount: function unmount() {
    unmountAll(this.expressions || []);
  }
}

/**
 * Create a new if directive
 * @param   { HTMLElement } dom - if root dom node
 * @param   { Tag } context - tag instance where the DOM node is located
 * @param   { String } attr - if expression
 * @returns { IFExpr } a new IfExpr object
 */
function createIfDirective(dom, tag, attr) {
  return create(IfExpr).init(dom, tag, attr)
}

/**
 * Walk the tag DOM to detect the expressions to evaluate
 * @this Tag
 * @param   { HTMLElement } root - root tag where we will start digging the expressions
 * @param   { Boolean } mustIncludeRoot - flag to decide whether the root must be parsed as well
 * @returns { Array } all the expressions found
 */
function parseExpressions(root, mustIncludeRoot) {
  var this$1 = this;

  var expressions = [];

  walkNodes(root, function (dom) {
    var type = dom.nodeType;
    var attr;
    var tagImpl;

    if (!mustIncludeRoot && dom === root) { return }

    // text node
    if (type === 3 && dom.parentNode.tagName !== 'STYLE' && tmpl.hasExpr(dom.nodeValue))
      { expressions.push({dom: dom, expr: dom.nodeValue}); }

    if (type !== 1) { return }

    var isVirtual = dom.tagName === 'VIRTUAL';

    // loop. each does it's own thing (for now)
    if (attr = getAttribute(dom, LOOP_DIRECTIVE)) {
      if(isVirtual) { setAttribute(dom, 'loopVirtual', true); } // ignore here, handled in _each
      expressions.push(_each(dom, this$1, attr));
      return false
    }

    // if-attrs become the new parent. Any following expressions (either on the current
    // element, or below it) become children of this expression.
    if (attr = getAttribute(dom, CONDITIONAL_DIRECTIVE)) {
      expressions.push(createIfDirective(dom, this$1, attr));
      return false
    }

    if (attr = getAttribute(dom, IS_DIRECTIVE)) {
      if (tmpl.hasExpr(attr)) {
        expressions.push({
          isRtag: true,
          expr: attr,
          dom: dom,
          attrs: [].slice.call(dom.attributes)
        });

        return false
      }
    }

    // if this is a tag, stop traversing here.
    // we ignore the root, since parseExpressions is called while we're mounting that root
    tagImpl = get(dom);

    if(isVirtual) {
      if(getAttribute(dom, 'virtualized')) {dom.parentElement.removeChild(dom); } // tag created, remove from dom
      if(!tagImpl && !getAttribute(dom, 'virtualized') && !getAttribute(dom, 'loopVirtual'))  // ok to create virtual tag
        { tagImpl = { tmpl: dom.outerHTML }; }
    }

    if (tagImpl && (dom !== root || mustIncludeRoot)) {
      if(isVirtual) { // handled in update
        if (getAttribute(dom, IS_DIRECTIVE))
          { warn(("Virtual tags shouldn't be used together with the \"" + IS_DIRECTIVE + "\" attribute - https://github.com/riot/riot/issues/2511")); }
        // can not remove attribute like directives
        // so flag for removal after creation to prevent maximum stack error
        setAttribute(dom, 'virtualized', true);
        var tag = createTag(
          {tmpl: dom.outerHTML},
          {root: dom, parent: this$1},
          dom.innerHTML
        );

        expressions.push(tag); // no return, anonymous tag, keep parsing
      } else {
        expressions.push(
          initChild(
            tagImpl,
            {
              root: dom,
              parent: this$1
            },
            dom.innerHTML,
            this$1
          )
        );
        return false
      }
    }

    // attribute expressions
    parseAttributes.apply(this$1, [dom, dom.attributes, function (attr, expr) {
      if (!expr) { return }
      expressions.push(expr);
    }]);
  });

  return expressions
}

/**
 * Calls `fn` for every attribute on an element. If that attr has an expression,
 * it is also passed to fn.
 * @this Tag
 * @param   { HTMLElement } dom - dom node to parse
 * @param   { Array } attrs - array of attributes
 * @param   { Function } fn - callback to exec on any iteration
 */
function parseAttributes(dom, attrs, fn) {
  var this$1 = this;

  each(attrs, function (attr) {
    if (!attr) { return false }

    var name = attr.name;
    var bool = isBoolAttr(name);
    var expr;

    if (contains(REF_DIRECTIVES, name) && dom.tagName.toLowerCase() !== YIELD_TAG) {
      expr =  createRefDirective(dom, this$1, name, attr.value);
    } else if (tmpl.hasExpr(attr.value)) {
      expr = {dom: dom, expr: attr.value, attr: name, bool: bool};
    }

    fn(attr, expr);
  });
}

/**
 * Manage the mount state of a tag triggering also the observable events
 * @this Tag
 * @param { Boolean } value - ..of the isMounted flag
 */
function setMountState(value) {
  var ref = this.__;
  var isAnonymous = ref.isAnonymous;

  define(this, 'isMounted', value);

  if (!isAnonymous) {
    if (value) { this.trigger('mount'); }
    else {
      this.trigger('unmount');
      this.off('*');
      this.__.wasCreated = false;
    }
  }
}

/**
 * Mount the current tag instance
 * @returns { Tag } the current tag instance
 */
function componentMount(tag$$1, dom, expressions, opts) {
  var __ = tag$$1.__;
  var root = __.root;
  root._tag = tag$$1; // keep a reference to the tag just created

  // Read all the attrs on this instance. This give us the info we need for updateOpts
  parseAttributes.apply(__.parent, [root, root.attributes, function (attr, expr) {
    if (!__.isAnonymous && RefExpr.isPrototypeOf(expr)) { expr.tag = tag$$1; }
    attr.expr = expr;
    __.instAttrs.push(attr);
  }]);

  // update the root adding custom attributes coming from the compiler
  walkAttributes(__.impl.attrs, function (k, v) { __.implAttrs.push({name: k, value: v}); });
  parseAttributes.apply(tag$$1, [root, __.implAttrs, function (attr, expr) {
    if (expr) { expressions.push(expr); }
    else { setAttribute(root, attr.name, attr.value); }
  }]);

  // initialiation
  updateOpts.apply(tag$$1, [__.isLoop, __.parent, __.isAnonymous, opts, __.instAttrs]);

  // add global mixins
  var globalMixin = mixin(GLOBAL_MIXIN);

  if (globalMixin && !__.skipAnonymous) {
    for (var i in globalMixin) {
      if (globalMixin.hasOwnProperty(i)) {
        tag$$1.mixin(globalMixin[i]);
      }
    }
  }

  if (__.impl.fn) { __.impl.fn.call(tag$$1, opts); }

  if (!__.skipAnonymous) { tag$$1.trigger('before-mount'); }

  // parse layout after init. fn may calculate args for nested custom tags
  each(parseExpressions.apply(tag$$1, [dom, __.isAnonymous]), function (e) { return expressions.push(e); });

  tag$$1.update(__.item);

  if (!__.isAnonymous && !__.isInline) {
    while (dom.firstChild) { root.appendChild(dom.firstChild); }
  }

  define(tag$$1, 'root', root);

  // if we need to wait that the parent "mount" or "updated" event gets triggered
  if (!__.skipAnonymous && tag$$1.parent) {
    var p = getImmediateCustomParent(tag$$1.parent);
    p.one(!p.isMounted ? 'mount' : 'updated', function () {
      setMountState.call(tag$$1, true);
    });
  } else {
    // otherwise it's not a child tag we can trigger its mount event
    setMountState.call(tag$$1, true);
  }

  tag$$1.__.wasCreated = true;

  return tag$$1
}

/**
 * Unmount the tag instance
 * @param { Boolean } mustKeepRoot - if it's true the root node will not be removed
 * @returns { Tag } the current tag instance
 */
function tagUnmount(tag, mustKeepRoot, expressions) {
  var __ = tag.__;
  var root = __.root;
  var tagIndex = __TAGS_CACHE.indexOf(tag);
  var p = root.parentNode;

  if (!__.skipAnonymous) { tag.trigger('before-unmount'); }

  // clear all attributes coming from the mounted tag
  walkAttributes(__.impl.attrs, function (name) {
    if (startsWith(name, ATTRS_PREFIX))
      { name = name.slice(ATTRS_PREFIX.length); }

    removeAttribute(root, name);
  });

  // remove all the event listeners
  tag.__.listeners.forEach(function (dom) {
    Object.keys(dom[RIOT_EVENTS_KEY]).forEach(function (eventName) {
      dom.removeEventListener(eventName, dom[RIOT_EVENTS_KEY][eventName]);
    });
  });

  // remove tag instance from the global tags cache collection
  if (tagIndex !== -1) { __TAGS_CACHE.splice(tagIndex, 1); }

  // clean up the parent tags object
  if (__.parent && !__.isAnonymous) {
    var ptag = getImmediateCustomParent(__.parent);

    if (__.isVirtual) {
      Object
        .keys(tag.tags)
        .forEach(function (tagName) { return arrayishRemove(ptag.tags, tagName, tag.tags[tagName]); });
    } else {
      arrayishRemove(ptag.tags, __.tagName, tag);
    }
  }

  // unmount all the virtual directives
  if (tag.__.virts) {
    each(tag.__.virts, function (v) {
      if (v.parentNode) { v.parentNode.removeChild(v); }
    });
  }

  // allow expressions to unmount themselves
  unmountAll(expressions);
  each(__.instAttrs, function (a) { return a.expr && a.expr.unmount && a.expr.unmount(); });

  // clear the tag html if it's necessary
  if (mustKeepRoot) { setInnerHTML(root, ''); }
  // otherwise detach the root tag from the DOM
  else if (p) { p.removeChild(root); }

  // custom internal unmount function to avoid relying on the observable
  if (__.onUnmount) { __.onUnmount(); }

  // weird fix for a weird edge case #2409 and #2436
  // some users might use your software not as you've expected
  // so I need to add these dirty hacks to mitigate unexpected issues
  if (!tag.isMounted) { setMountState.call(tag, true); }

  setMountState.call(tag, false);

  delete root._tag;

  return tag
}

/**
 * Tag creation factory function
 * @constructor
 * @param { Object } impl - it contains the tag template, and logic
 * @param { Object } conf - tag options
 * @param { String } innerHTML - html that eventually we need to inject in the tag
 */
function createTag(impl, conf, innerHTML) {
  if ( impl === void 0 ) impl = {};
  if ( conf === void 0 ) conf = {};

  var tag = conf.context || {};
  var opts = extend({}, conf.opts);
  var parent = conf.parent;
  var isLoop = conf.isLoop;
  var isAnonymous = !!conf.isAnonymous;
  var skipAnonymous = settings.skipAnonymousTags && isAnonymous;
  var item = conf.item;
  // available only for the looped nodes
  var index = conf.index;
  // All attributes on the Tag when it's first parsed
  var instAttrs = [];
  // expressions on this type of Tag
  var implAttrs = [];
  var expressions = [];
  var root = conf.root;
  var tagName = conf.tagName || getName(root);
  var isVirtual = tagName === 'virtual';
  var isInline = !isVirtual && !impl.tmpl;
  var dom;

  // make this tag observable
  if (!skipAnonymous) { observable(tag); }
  // only call unmount if we have a valid __TAG_IMPL (has name property)
  if (impl.name && root._tag) { root._tag.unmount(true); }

  // not yet mounted
  define(tag, 'isMounted', false);

  define(tag, '__', {
    impl: impl,
    root: root,
    skipAnonymous: skipAnonymous,
    implAttrs: implAttrs,
    isAnonymous: isAnonymous,
    instAttrs: instAttrs,
    innerHTML: innerHTML,
    tagName: tagName,
    index: index,
    isLoop: isLoop,
    isInline: isInline,
    item: item,
    parent: parent,
    // tags having event listeners
    // it would be better to use weak maps here but we can not introduce breaking changes now
    listeners: [],
    // these vars will be needed only for the virtual tags
    virts: [],
    wasCreated: false,
    tail: null,
    head: null
  });

  // create a unique id to this tag
  // it could be handy to use it also to improve the virtual dom rendering speed
  define(tag, '_riot_id', uid()); // base 1 allows test !t._riot_id
  define(tag, 'root', root);
  extend(tag, { opts: opts }, item);
  // protect the "tags" and "refs" property from being overridden
  define(tag, 'parent', parent || null);
  define(tag, 'tags', {});
  define(tag, 'refs', {});

  if (isInline || isLoop && isAnonymous) {
    dom = root;
  } else {
    if (!isVirtual) { root.innerHTML = ''; }
    dom = mkdom(impl.tmpl, innerHTML, isSvg(root));
  }

  define(tag, 'update', function (data) { return componentUpdate(tag, data, expressions); });
  define(tag, 'mixin', function () {
    var mixins = [], len = arguments.length;
    while ( len-- ) mixins[ len ] = arguments[ len ];

    return componentMixin.apply(void 0, [ tag ].concat( mixins ));
  });
  define(tag, 'mount', function () { return componentMount(tag, dom, expressions, opts); });
  define(tag, 'unmount', function (mustKeepRoot) { return tagUnmount(tag, mustKeepRoot, expressions); });

  return tag
}

/**
 * Mount a tag creating new Tag instance
 * @param   { Object } root - dom node where the tag will be mounted
 * @param   { String } tagName - name of the riot tag we want to mount
 * @param   { Object } opts - options to pass to the Tag instance
 * @param   { Object } ctx - optional context that will be used to extend an existing class ( used in riot.Tag )
 * @returns { Tag } a new Tag instance
 */
function mount$1(root, tagName, opts, ctx) {
  var impl = __TAG_IMPL[tagName];
  var implClass = __TAG_IMPL[tagName].class;
  var context = ctx || (implClass ? create(implClass.prototype) : {});
  // cache the inner HTML to fix #855
  var innerHTML = root._innerHTML = root._innerHTML || root.innerHTML;
  var conf = extend({ root: root, opts: opts, context: context }, { parent: opts ? opts.parent : null });
  var tag;

  if (impl && root) { tag = createTag(impl, conf, innerHTML); }

  if (tag && tag.mount) {
    tag.mount(true);
    // add this tag to the virtualDom variable
    if (!contains(__TAGS_CACHE, tag)) { __TAGS_CACHE.push(tag); }
  }

  return tag
}



var tags = Object.freeze({
	arrayishAdd: arrayishAdd,
	getTagName: getName,
	inheritParentProps: inheritParentProps,
	mountTo: mount$1,
	selectTags: query,
	arrayishRemove: arrayishRemove,
	getTag: get,
	initChildTag: initChild,
	moveChildTag: moveChild,
	makeReplaceVirtual: makeReplaceVirtual,
	getImmediateCustomParentTag: getImmediateCustomParent,
	makeVirtual: makeVirtual,
	moveVirtual: moveVirtual,
	unmountAll: unmountAll,
	createIfDirective: createIfDirective,
	createRefDirective: createRefDirective
});

/**
 * Riot public api
 */
var settings$1 = settings;
var util = {
  tmpl: tmpl,
  brackets: brackets,
  styleManager: styleManager,
  vdom: __TAGS_CACHE,
  styleNode: styleManager.styleNode,
  // export the riot internal utils as well
  dom: dom,
  check: check,
  misc: misc,
  tags: tags
};

// export the core props/methods
var Tag$1 = Tag;
var tag$1 = tag;
var tag2$1 = tag2;
var mount$2 = mount;
var mixin$1 = mixin;
var update$2 = update$1;
var unregister$1 = unregister;
var version$1 = version;
var observable$2 = observable;

var riot$1 = extend({}, core, {
  observable: observable,
  settings: settings$1,
  util: util,
})

exports.settings = settings$1;
exports.util = util;
exports.Tag = Tag$1;
exports.tag = tag$1;
exports.tag2 = tag2$1;
exports.mount = mount$2;
exports.mixin = mixin$1;
exports.update = update$2;
exports.unregister = unregister$1;
exports.version = version$1;
exports.observable = observable$2;
exports.default = riot$1;

Object.defineProperty(exports, '__esModule', { value: true });

})));


/***/ }),
/* 1 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


Object.defineProperty(exports, "__esModule", {
    value: true
});

exports.default = function (method, args, callback) {
    var _call = '/' + method + '?';
    for (var key in args) {
        _call += key + '=' + encodeURI(args[key]) + '&';
    }
    _call += 'public_id=' + window.status;
    instance.get(_call, { withCredentials: true }).then(callback).catch(function (error) {
        console.log(error);
    });
};

var _axios = __webpack_require__(81);

var _axios2 = _interopRequireDefault(_axios);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

var instance = _axios2.default.create({
    baseURL: 'http://phonetworks.com:1338',
    timeout: 20000,
    headers: { 'Content-Type': 'application/json' }
});

;

/***/ }),
/* 2 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


Object.defineProperty(exports, "__esModule", {
    value: true
});

exports.default = function (component, specs, code) {
    var tag = createTag(component, specs);
    code.innerHTML = tag.outerHTML;
};

var _riot = __webpack_require__(0);

var _riot2 = _interopRequireDefault(_riot);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function createTag(component, specs) {
    var tag = document.createElement(component);
    for (var _iterator = Object.keys(specs), _isArray = Array.isArray(_iterator), _i = 0, _iterator = _isArray ? _iterator : _iterator[Symbol.iterator]();;) {
        var _ref;

        if (_isArray) {
            if (_i >= _iterator.length) break;
            _ref = _iterator[_i++];
        } else {
            _i = _iterator.next();
            if (_i.done) break;
            _ref = _i.value;
        }

        var key = _ref;

        var attribute = document.createAttribute(key);
        attribute.value = specs[key];
        tag.setAttributeNode(attribute);
    }
    return tag;
}

/***/ }),
/* 3 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


Object.defineProperty(exports, "__esModule", {
    value: true
});

exports.default = function (component, specs, display) {
    var tag = createTag(component, specs);
    display.innerHTML = '';
    display.appendChild(tag);
    _riot2.default.mount(tag);
};

var _riot = __webpack_require__(0);

var _riot2 = _interopRequireDefault(_riot);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function createTag(component, specs) {
    var tag = document.createElement(component);
    for (var _iterator = Object.keys(specs), _isArray = Array.isArray(_iterator), _i = 0, _iterator = _isArray ? _iterator : _iterator[Symbol.iterator]();;) {
        var _ref;

        if (_isArray) {
            if (_i >= _iterator.length) break;
            _ref = _iterator[_i++];
        } else {
            _i = _iterator.next();
            if (_i.done) break;
            _ref = _i.value;
        }

        var key = _ref;

        var attribute = document.createAttribute(key);
        attribute.value = specs[key];
        tag.setAttributeNode(attribute);
    }
    return tag;
}

/***/ }),
/* 4 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


Object.defineProperty(exports, "__esModule", {
    value: true
});

exports.default = function (tagName, specs) {
    // Remove previous overlay
    (0, _hideOverlay2.default)();
    // Create new overlay
    var newOverlayItem = document.createElement('graphjs-overlay');
    // Set component property on overlay
    var component = document.createAttribute('component');
    component.value = tagName;
    newOverlayItem.setAttributeNode(component);
    // Set specs of component on overlay
    if (specs) {
        for (var _iterator = Object.keys(specs), _isArray = Array.isArray(_iterator), _i = 0, _iterator = _isArray ? _iterator : _iterator[Symbol.iterator]();;) {
            var _ref;

            if (_isArray) {
                if (_i >= _iterator.length) break;
                _ref = _iterator[_i++];
            } else {
                _i = _iterator.next();
                if (_i.done) break;
                _ref = _i.value;
            }

            var key = _ref;

            var attribute = document.createAttribute(key);
            attribute.value = specs[key];
            newOverlayItem.setAttributeNode(attribute);
        }
    }
    // Mount & append overlay
    _riot2.default.mount(newOverlayItem);
    document.body.appendChild(newOverlayItem);
};

var _riot = __webpack_require__(0);

var _riot2 = _interopRequireDefault(_riot);

var _hideOverlay = __webpack_require__(22);

var _hideOverlay2 = _interopRequireDefault(_hideOverlay);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

/***/ }),
/* 5 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


var bind = __webpack_require__(27);
var isBuffer = __webpack_require__(83);

/*global toString:true*/

// utils is a library of generic helper functions non-specific to axios

var toString = Object.prototype.toString;

/**
 * Determine if a value is an Array
 *
 * @param {Object} val The value to test
 * @returns {boolean} True if value is an Array, otherwise false
 */
function isArray(val) {
  return toString.call(val) === '[object Array]';
}

/**
 * Determine if a value is an ArrayBuffer
 *
 * @param {Object} val The value to test
 * @returns {boolean} True if value is an ArrayBuffer, otherwise false
 */
function isArrayBuffer(val) {
  return toString.call(val) === '[object ArrayBuffer]';
}

/**
 * Determine if a value is a FormData
 *
 * @param {Object} val The value to test
 * @returns {boolean} True if value is an FormData, otherwise false
 */
function isFormData(val) {
  return (typeof FormData !== 'undefined') && (val instanceof FormData);
}

/**
 * Determine if a value is a view on an ArrayBuffer
 *
 * @param {Object} val The value to test
 * @returns {boolean} True if value is a view on an ArrayBuffer, otherwise false
 */
function isArrayBufferView(val) {
  var result;
  if ((typeof ArrayBuffer !== 'undefined') && (ArrayBuffer.isView)) {
    result = ArrayBuffer.isView(val);
  } else {
    result = (val) && (val.buffer) && (val.buffer instanceof ArrayBuffer);
  }
  return result;
}

/**
 * Determine if a value is a String
 *
 * @param {Object} val The value to test
 * @returns {boolean} True if value is a String, otherwise false
 */
function isString(val) {
  return typeof val === 'string';
}

/**
 * Determine if a value is a Number
 *
 * @param {Object} val The value to test
 * @returns {boolean} True if value is a Number, otherwise false
 */
function isNumber(val) {
  return typeof val === 'number';
}

/**
 * Determine if a value is undefined
 *
 * @param {Object} val The value to test
 * @returns {boolean} True if the value is undefined, otherwise false
 */
function isUndefined(val) {
  return typeof val === 'undefined';
}

/**
 * Determine if a value is an Object
 *
 * @param {Object} val The value to test
 * @returns {boolean} True if value is an Object, otherwise false
 */
function isObject(val) {
  return val !== null && typeof val === 'object';
}

/**
 * Determine if a value is a Date
 *
 * @param {Object} val The value to test
 * @returns {boolean} True if value is a Date, otherwise false
 */
function isDate(val) {
  return toString.call(val) === '[object Date]';
}

/**
 * Determine if a value is a File
 *
 * @param {Object} val The value to test
 * @returns {boolean} True if value is a File, otherwise false
 */
function isFile(val) {
  return toString.call(val) === '[object File]';
}

/**
 * Determine if a value is a Blob
 *
 * @param {Object} val The value to test
 * @returns {boolean} True if value is a Blob, otherwise false
 */
function isBlob(val) {
  return toString.call(val) === '[object Blob]';
}

/**
 * Determine if a value is a Function
 *
 * @param {Object} val The value to test
 * @returns {boolean} True if value is a Function, otherwise false
 */
function isFunction(val) {
  return toString.call(val) === '[object Function]';
}

/**
 * Determine if a value is a Stream
 *
 * @param {Object} val The value to test
 * @returns {boolean} True if value is a Stream, otherwise false
 */
function isStream(val) {
  return isObject(val) && isFunction(val.pipe);
}

/**
 * Determine if a value is a URLSearchParams object
 *
 * @param {Object} val The value to test
 * @returns {boolean} True if value is a URLSearchParams object, otherwise false
 */
function isURLSearchParams(val) {
  return typeof URLSearchParams !== 'undefined' && val instanceof URLSearchParams;
}

/**
 * Trim excess whitespace off the beginning and end of a string
 *
 * @param {String} str The String to trim
 * @returns {String} The String freed of excess whitespace
 */
function trim(str) {
  return str.replace(/^\s*/, '').replace(/\s*$/, '');
}

/**
 * Determine if we're running in a standard browser environment
 *
 * This allows axios to run in a web worker, and react-native.
 * Both environments support XMLHttpRequest, but not fully standard globals.
 *
 * web workers:
 *  typeof window -> undefined
 *  typeof document -> undefined
 *
 * react-native:
 *  navigator.product -> 'ReactNative'
 */
function isStandardBrowserEnv() {
  if (typeof navigator !== 'undefined' && navigator.product === 'ReactNative') {
    return false;
  }
  return (
    typeof window !== 'undefined' &&
    typeof document !== 'undefined'
  );
}

/**
 * Iterate over an Array or an Object invoking a function for each item.
 *
 * If `obj` is an Array callback will be called passing
 * the value, index, and complete array for each item.
 *
 * If 'obj' is an Object callback will be called passing
 * the value, key, and complete object for each property.
 *
 * @param {Object|Array} obj The object to iterate
 * @param {Function} fn The callback to invoke for each item
 */
function forEach(obj, fn) {
  // Don't bother if no value provided
  if (obj === null || typeof obj === 'undefined') {
    return;
  }

  // Force an array if not already something iterable
  if (typeof obj !== 'object') {
    /*eslint no-param-reassign:0*/
    obj = [obj];
  }

  if (isArray(obj)) {
    // Iterate over array values
    for (var i = 0, l = obj.length; i < l; i++) {
      fn.call(null, obj[i], i, obj);
    }
  } else {
    // Iterate over object keys
    for (var key in obj) {
      if (Object.prototype.hasOwnProperty.call(obj, key)) {
        fn.call(null, obj[key], key, obj);
      }
    }
  }
}

/**
 * Accepts varargs expecting each argument to be an object, then
 * immutably merges the properties of each object and returns result.
 *
 * When multiple objects contain the same key the later object in
 * the arguments list will take precedence.
 *
 * Example:
 *
 * ```js
 * var result = merge({foo: 123}, {foo: 456});
 * console.log(result.foo); // outputs 456
 * ```
 *
 * @param {Object} obj1 Object to merge
 * @returns {Object} Result of all merge properties
 */
function merge(/* obj1, obj2, obj3, ... */) {
  var result = {};
  function assignValue(val, key) {
    if (typeof result[key] === 'object' && typeof val === 'object') {
      result[key] = merge(result[key], val);
    } else {
      result[key] = val;
    }
  }

  for (var i = 0, l = arguments.length; i < l; i++) {
    forEach(arguments[i], assignValue);
  }
  return result;
}

/**
 * Extends object a by mutably adding to it the properties of object b.
 *
 * @param {Object} a The object to be extended
 * @param {Object} b The object to copy properties from
 * @param {Object} thisArg The object to bind function to
 * @return {Object} The resulting value of object a
 */
function extend(a, b, thisArg) {
  forEach(b, function assignValue(val, key) {
    if (thisArg && typeof val === 'function') {
      a[key] = bind(val, thisArg);
    } else {
      a[key] = val;
    }
  });
  return a;
}

module.exports = {
  isArray: isArray,
  isArrayBuffer: isArrayBuffer,
  isBuffer: isBuffer,
  isFormData: isFormData,
  isArrayBufferView: isArrayBufferView,
  isString: isString,
  isNumber: isNumber,
  isObject: isObject,
  isUndefined: isUndefined,
  isDate: isDate,
  isFile: isFile,
  isBlob: isBlob,
  isFunction: isFunction,
  isStream: isStream,
  isURLSearchParams: isURLSearchParams,
  isStandardBrowserEnv: isStandardBrowserEnv,
  forEach: forEach,
  merge: merge,
  extend: extend,
  trim: trim
};


/***/ }),
/* 6 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


Object.defineProperty(exports, "__esModule", {
	value: true
});

exports.default = function (callback) {
	getUserCall(callback);
};

var _api = __webpack_require__(1);

var _api2 = _interopRequireDefault(_api);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function getUserCall(callback) {
	(0, _api2.default)("whoami", {}, function (response) {
		callback(response.data);
	});
};

;

/***/ }),
/* 7 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


Object.defineProperty(exports, "__esModule", {
	value: true
});

exports.default = function () {
	var args = Array.from(arguments);
	var callback = args.pop();
	getProfileCall(args, callback);
};

var _api = __webpack_require__(1);

var _api2 = _interopRequireDefault(_api);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function getProfileCall(args, callback) {
	(0, _api2.default)("getProfile", {
		"id": args[0]
	}, function (response) {
		callback(response.data);
	});
};

;

/***/ }),
/* 8 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


Object.defineProperty(exports, "__esModule", {
	value: true
});

exports.default = function (specs) {
	(0, _showOverlay2.default)(tagName, specs);
};

var _showOverlay = __webpack_require__(4);

var _showOverlay2 = _interopRequireDefault(_showOverlay);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

var tagName = 'graphjs-auth-register';

/***/ }),
/* 9 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


Object.defineProperty(exports, "__esModule", {
	value: true
});

exports.default = function (specs) {
	(0, _showOverlay2.default)(tagName, specs);
};

var _showOverlay = __webpack_require__(4);

var _showOverlay2 = _interopRequireDefault(_showOverlay);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

var tagName = 'graphjs-alert';

/***/ }),
/* 10 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


Object.defineProperty(exports, "__esModule", {
	value: true
});

exports.default = function (specs) {
	(0, _showOverlay2.default)(tagName, specs);
};

var _showOverlay = __webpack_require__(4);

var _showOverlay2 = _interopRequireDefault(_showOverlay);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

var tagName = 'graphjs-auth-login';

/***/ }),
/* 11 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


Object.defineProperty(exports, "__esModule", {
	value: true
});

exports.default = function (specs) {
	(0, _showOverlay2.default)(tagName, specs);
};

var _showOverlay = __webpack_require__(4);

var _showOverlay2 = _interopRequireDefault(_showOverlay);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

var tagName = 'graphjs-messages';

/***/ }),
/* 12 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


Object.defineProperty(exports, "__esModule", {
	value: true
});

exports.default = function () {
	var args = Array.from(arguments);
	var callback = args.pop();
	listMembersCall(args, callback);
};

var _api = __webpack_require__(1);

var _api2 = _interopRequireDefault(_api);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function listMembersCall(args, callback) {
	(0, _api2.default)("listMembers", {
		"id": args[0]
	}, function (response) {
		callback(response.data);
	});
};

;

/***/ }),
/* 13 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


Object.defineProperty(exports, "__esModule", {
	value: true
});

exports.default = function (specs) {
	(0, _showOverlay2.default)(tagName, specs);
};

var _showOverlay = __webpack_require__(4);

var _showOverlay2 = _interopRequireDefault(_showOverlay);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

var tagName = 'graphjs-auth-reset';

/***/ }),
/* 14 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


Object.defineProperty(exports, "__esModule", {
	value: true
});

exports.default = function () {
	var args = Array.from(arguments);
	var callback = args.pop();
	loginCall(args, callback);
};

var _api = __webpack_require__(1);

var _api2 = _interopRequireDefault(_api);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function loginCall(args, callback) {
	(0, _api2.default)("login", {
		"username": args[0],
		"password": args[1]
	}, function (response) {
		callback(response.data);
	});
};

;

/***/ }),
/* 15 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";
/* WEBPACK VAR INJECTION */(function(process) {

var utils = __webpack_require__(5);
var normalizeHeaderName = __webpack_require__(85);

var DEFAULT_CONTENT_TYPE = {
  'Content-Type': 'application/x-www-form-urlencoded'
};

function setContentTypeIfUnset(headers, value) {
  if (!utils.isUndefined(headers) && utils.isUndefined(headers['Content-Type'])) {
    headers['Content-Type'] = value;
  }
}

function getDefaultAdapter() {
  var adapter;
  if (typeof XMLHttpRequest !== 'undefined') {
    // For browsers use XHR adapter
    adapter = __webpack_require__(29);
  } else if (typeof process !== 'undefined') {
    // For node use HTTP adapter
    adapter = __webpack_require__(29);
  }
  return adapter;
}

var defaults = {
  adapter: getDefaultAdapter(),

  transformRequest: [function transformRequest(data, headers) {
    normalizeHeaderName(headers, 'Content-Type');
    if (utils.isFormData(data) ||
      utils.isArrayBuffer(data) ||
      utils.isBuffer(data) ||
      utils.isStream(data) ||
      utils.isFile(data) ||
      utils.isBlob(data)
    ) {
      return data;
    }
    if (utils.isArrayBufferView(data)) {
      return data.buffer;
    }
    if (utils.isURLSearchParams(data)) {
      setContentTypeIfUnset(headers, 'application/x-www-form-urlencoded;charset=utf-8');
      return data.toString();
    }
    if (utils.isObject(data)) {
      setContentTypeIfUnset(headers, 'application/json;charset=utf-8');
      return JSON.stringify(data);
    }
    return data;
  }],

  transformResponse: [function transformResponse(data) {
    /*eslint no-param-reassign:0*/
    if (typeof data === 'string') {
      try {
        data = JSON.parse(data);
      } catch (e) { /* Ignore */ }
    }
    return data;
  }],

  timeout: 0,

  xsrfCookieName: 'XSRF-TOKEN',
  xsrfHeaderName: 'X-XSRF-TOKEN',

  maxContentLength: -1,

  validateStatus: function validateStatus(status) {
    return status >= 200 && status < 300;
  }
};

defaults.headers = {
  common: {
    'Accept': 'application/json, text/plain, */*'
  }
};

utils.forEach(['delete', 'get', 'head'], function forEachMethodNoData(method) {
  defaults.headers[method] = {};
});

utils.forEach(['post', 'put', 'patch'], function forEachMethodWithData(method) {
  defaults.headers[method] = utils.merge(DEFAULT_CONTENT_TYPE);
});

module.exports = defaults;

/* WEBPACK VAR INJECTION */}.call(exports, __webpack_require__(28)))

/***/ }),
/* 16 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


Object.defineProperty(exports, "__esModule", {
	value: true
});

exports.default = function (callback) {
	getStarsCall(callback);
};

var _api = __webpack_require__(1);

var _api2 = _interopRequireDefault(_api);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function getStarsCall(callback) {
	(0, _api2.default)("getStarredContent", {}, function (response) {
		callback(response.data);
	});
};

;

/***/ }),
/* 17 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


Object.defineProperty(exports, "__esModule", {
	value: true
});

exports.default = function () {
	var args = Array.from(arguments);
	var callback = args.pop();
	removeStarCall(args, callback);
};

var _api = __webpack_require__(1);

var _api2 = _interopRequireDefault(_api);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function removeStarCall(args, callback) {
	(0, _api2.default)("unstar", {
		"url": args[0]
	}, function (response) {
		callback(response.data);
	});
};

;

/***/ }),
/* 18 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


Object.defineProperty(exports, "__esModule", {
	value: true
});

exports.default = function (specs) {
	(0, _showOverlay2.default)(tagName, specs);
};

var _showOverlay = __webpack_require__(4);

var _showOverlay2 = _interopRequireDefault(_showOverlay);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

var tagName = 'graphjs-forum-thread';

/***/ }),
/* 19 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


Object.defineProperty(exports, "__esModule", {
	value: true
});

exports.default = function (specs) {
	(0, _showOverlay2.default)(tagName, specs);
};

var _showOverlay = __webpack_require__(4);

var _showOverlay2 = _interopRequireDefault(_showOverlay);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

var tagName = 'graphjs-forum-list';

/***/ }),
/* 20 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


Object.defineProperty(exports, "__esModule", {
	value: true
});

exports.default = function () {
	var args = Array.from(arguments);
	var callback = args.pop();
	joinGroupCall(args, callback);
};

var _api = __webpack_require__(1);

var _api2 = _interopRequireDefault(_api);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function joinGroupCall(args, callback) {
	(0, _api2.default)("join", {
		"id": args[0]
	}, function (response) {
		callback(response.data);
	});
};

;

/***/ }),
/* 21 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


Object.defineProperty(exports, "__esModule", {
	value: true
});

exports.default = function (specs) {
	(0, _showOverlay2.default)(tagName, specs);
};

var _showOverlay = __webpack_require__(4);

var _showOverlay2 = _interopRequireDefault(_showOverlay);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

var tagName = 'graphjs-group';

/***/ }),
/* 22 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


Object.defineProperty(exports, "__esModule", {
    value: true
});

exports.default = function () {
    // Remove previous overlay
    var previousOverlayItem = document.querySelector('graphjs-overlay');
    previousOverlayItem && previousOverlayItem.parentNode.removeChild(previousOverlayItem);
};

/***/ }),
/* 23 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


Object.defineProperty(exports, "__esModule", {
	value: true
});

exports.default = function (specs) {
	(0, _showOverlay2.default)(tagName, specs);
};

var _showOverlay = __webpack_require__(4);

var _showOverlay2 = _interopRequireDefault(_showOverlay);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

var tagName = 'graphjs-auth';

/***/ }),
/* 24 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


Object.defineProperty(exports, "__esModule", {
	value: true
});

exports.default = function (specs) {
	(0, _showOverlay2.default)(tagName, specs);
};

var _showOverlay = __webpack_require__(4);

var _showOverlay2 = _interopRequireDefault(_showOverlay);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

var tagName = 'graphjs-comments';

/***/ }),
/* 25 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


Object.defineProperty(exports, "__esModule", {
	value: true
});

exports.default = function (specs) {
	(0, _showOverlay2.default)(tagName, specs);
};

var _showOverlay = __webpack_require__(4);

var _showOverlay2 = _interopRequireDefault(_showOverlay);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

var tagName = 'graphjs-forum';

/***/ }),
/* 26 */
/***/ (function(module, exports, __webpack_require__) {


    var riot = __webpack_require__(0)
    riot.tag2('graphjs-auth-login', '<div class="header" if="{opts.title}"> <div class="title">{opts.title || \'Login\'}</div> </div> <div class="warning" if="{warningMessages.length > 0}"> <ul if="{warningMessages.length > 0}" class="fail"> <li each="{warningMessage in warningMessages}">{warningMessage}</li> </ul> </div> <div class="content"> <form> <input ref="username" type="text" placeholder="Enter your username"> <input ref="password" type="password" placeholder="Enter your password"> <button onclick="{handleSubmit}">Login</button> <div class="option double"> <a data-link="register" onclick="{opts.minor ? opts.callback : handleRegisterBox}">Not registered?</a> <a data-link="reset" onclick="{opts.minor ? opts.callback : handleResetBox}">Forgot Password</a> </div> </form> </div>', 'graphjs-auth-login{display:block;color:rgba(63,95,127,0.65)}', 'class="{opts.minor != true && \'box\'}"', function(opts) {
'use strict';

var _this = this;

var _login = __webpack_require__(14);

var _login2 = _interopRequireDefault(_login);

var _showAlert = __webpack_require__(9);

var _showAlert2 = _interopRequireDefault(_showAlert);

var _showRegister = __webpack_require__(8);

var _showRegister2 = _interopRequireDefault(_showRegister);

var _showReset = __webpack_require__(13);

var _showReset2 = _interopRequireDefault(_showReset);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

this.handleRegisterBox = function () {
    return (0, _showRegister2.default)();
};
this.handleResetBox = function () {
    return (0, _showReset2.default)();
};

this.warningMessages = [];
this.checkUsernamePattern = function () {
    var warningMessage = 'Username is invalid. Valid characters are letters, numbers, hyphens, and underscores.';
    var usernamePattern = /^[a-zA-Z0-9-_]+$/;
    if (usernamePattern.test(_this.refs.username.value)) {
        _this.refs.username.classList.remove('error');
        _this.warningMessages.includes(warningMessage) && _this.warningMessages.splice(_this.warningMessages.indexOf(warningMessage), 1);
        return true;
    } else {
        _this.refs.username.classList.add('error');
        _this.warningMessages.includes(warningMessage) || _this.warningMessages.push(warningMessage);
        return false;
    }
};
this.validateForm = function () {
    var validUsernamePattern = _this.checkUsernamePattern();
    return validUsernamePattern ? true : false;
};
this.handleSubmit = function (event) {
    event.preventDefault();
    _this.validateForm() && (0, _login2.default)(_this.refs.username.value, _this.refs.password.value, function (response) {
        if (response.success) {
            (0, _showAlert2.default)({
                title: 'Login Succeeded!',
                message: 'You are successfully logged in.',
                customoption: 'Done'
            });
        } else {
            (0, _showAlert2.default)({
                title: 'Login Failed!',
                message: response.reason || 'Please try logging in again.',
                customoption: 'Retry',
                show: 'login',
                negativeoption: 'Cancel'
            });
        }
    });
};
});
    
  if (false) {
    module.hot.accept()
    if (module.hot.data) {
      riot.reload('graphjs-auth-login')
    }
  }
  

/***/ }),
/* 27 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


module.exports = function bind(fn, thisArg) {
  return function wrap() {
    var args = new Array(arguments.length);
    for (var i = 0; i < args.length; i++) {
      args[i] = arguments[i];
    }
    return fn.apply(thisArg, args);
  };
};


/***/ }),
/* 28 */
/***/ (function(module, exports) {

// shim for using process in browser
var process = module.exports = {};

// cached from whatever global is present so that test runners that stub it
// don't break things.  But we need to wrap it in a try catch in case it is
// wrapped in strict mode code which doesn't define any globals.  It's inside a
// function because try/catches deoptimize in certain engines.

var cachedSetTimeout;
var cachedClearTimeout;

function defaultSetTimout() {
    throw new Error('setTimeout has not been defined');
}
function defaultClearTimeout () {
    throw new Error('clearTimeout has not been defined');
}
(function () {
    try {
        if (typeof setTimeout === 'function') {
            cachedSetTimeout = setTimeout;
        } else {
            cachedSetTimeout = defaultSetTimout;
        }
    } catch (e) {
        cachedSetTimeout = defaultSetTimout;
    }
    try {
        if (typeof clearTimeout === 'function') {
            cachedClearTimeout = clearTimeout;
        } else {
            cachedClearTimeout = defaultClearTimeout;
        }
    } catch (e) {
        cachedClearTimeout = defaultClearTimeout;
    }
} ())
function runTimeout(fun) {
    if (cachedSetTimeout === setTimeout) {
        //normal enviroments in sane situations
        return setTimeout(fun, 0);
    }
    // if setTimeout wasn't available but was latter defined
    if ((cachedSetTimeout === defaultSetTimout || !cachedSetTimeout) && setTimeout) {
        cachedSetTimeout = setTimeout;
        return setTimeout(fun, 0);
    }
    try {
        // when when somebody has screwed with setTimeout but no I.E. maddness
        return cachedSetTimeout(fun, 0);
    } catch(e){
        try {
            // When we are in I.E. but the script has been evaled so I.E. doesn't trust the global object when called normally
            return cachedSetTimeout.call(null, fun, 0);
        } catch(e){
            // same as above but when it's a version of I.E. that must have the global object for 'this', hopfully our context correct otherwise it will throw a global error
            return cachedSetTimeout.call(this, fun, 0);
        }
    }


}
function runClearTimeout(marker) {
    if (cachedClearTimeout === clearTimeout) {
        //normal enviroments in sane situations
        return clearTimeout(marker);
    }
    // if clearTimeout wasn't available but was latter defined
    if ((cachedClearTimeout === defaultClearTimeout || !cachedClearTimeout) && clearTimeout) {
        cachedClearTimeout = clearTimeout;
        return clearTimeout(marker);
    }
    try {
        // when when somebody has screwed with setTimeout but no I.E. maddness
        return cachedClearTimeout(marker);
    } catch (e){
        try {
            // When we are in I.E. but the script has been evaled so I.E. doesn't  trust the global object when called normally
            return cachedClearTimeout.call(null, marker);
        } catch (e){
            // same as above but when it's a version of I.E. that must have the global object for 'this', hopfully our context correct otherwise it will throw a global error.
            // Some versions of I.E. have different rules for clearTimeout vs setTimeout
            return cachedClearTimeout.call(this, marker);
        }
    }



}
var queue = [];
var draining = false;
var currentQueue;
var queueIndex = -1;

function cleanUpNextTick() {
    if (!draining || !currentQueue) {
        return;
    }
    draining = false;
    if (currentQueue.length) {
        queue = currentQueue.concat(queue);
    } else {
        queueIndex = -1;
    }
    if (queue.length) {
        drainQueue();
    }
}

function drainQueue() {
    if (draining) {
        return;
    }
    var timeout = runTimeout(cleanUpNextTick);
    draining = true;

    var len = queue.length;
    while(len) {
        currentQueue = queue;
        queue = [];
        while (++queueIndex < len) {
            if (currentQueue) {
                currentQueue[queueIndex].run();
            }
        }
        queueIndex = -1;
        len = queue.length;
    }
    currentQueue = null;
    draining = false;
    runClearTimeout(timeout);
}

process.nextTick = function (fun) {
    var args = new Array(arguments.length - 1);
    if (arguments.length > 1) {
        for (var i = 1; i < arguments.length; i++) {
            args[i - 1] = arguments[i];
        }
    }
    queue.push(new Item(fun, args));
    if (queue.length === 1 && !draining) {
        runTimeout(drainQueue);
    }
};

// v8 likes predictible objects
function Item(fun, array) {
    this.fun = fun;
    this.array = array;
}
Item.prototype.run = function () {
    this.fun.apply(null, this.array);
};
process.title = 'browser';
process.browser = true;
process.env = {};
process.argv = [];
process.version = ''; // empty string to avoid regexp issues
process.versions = {};

function noop() {}

process.on = noop;
process.addListener = noop;
process.once = noop;
process.off = noop;
process.removeListener = noop;
process.removeAllListeners = noop;
process.emit = noop;
process.prependListener = noop;
process.prependOnceListener = noop;

process.listeners = function (name) { return [] }

process.binding = function (name) {
    throw new Error('process.binding is not supported');
};

process.cwd = function () { return '/' };
process.chdir = function (dir) {
    throw new Error('process.chdir is not supported');
};
process.umask = function() { return 0; };


/***/ }),
/* 29 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";
/* WEBPACK VAR INJECTION */(function(process) {

var utils = __webpack_require__(5);
var settle = __webpack_require__(86);
var buildURL = __webpack_require__(88);
var parseHeaders = __webpack_require__(89);
var isURLSameOrigin = __webpack_require__(90);
var createError = __webpack_require__(30);
var btoa = (typeof window !== 'undefined' && window.btoa && window.btoa.bind(window)) || __webpack_require__(91);

module.exports = function xhrAdapter(config) {
  return new Promise(function dispatchXhrRequest(resolve, reject) {
    var requestData = config.data;
    var requestHeaders = config.headers;

    if (utils.isFormData(requestData)) {
      delete requestHeaders['Content-Type']; // Let the browser set it
    }

    var request = new XMLHttpRequest();
    var loadEvent = 'onreadystatechange';
    var xDomain = false;

    // For IE 8/9 CORS support
    // Only supports POST and GET calls and doesn't returns the response headers.
    // DON'T do this for testing b/c XMLHttpRequest is mocked, not XDomainRequest.
    if (process.env.NODE_ENV !== 'test' &&
        typeof window !== 'undefined' &&
        window.XDomainRequest && !('withCredentials' in request) &&
        !isURLSameOrigin(config.url)) {
      request = new window.XDomainRequest();
      loadEvent = 'onload';
      xDomain = true;
      request.onprogress = function handleProgress() {};
      request.ontimeout = function handleTimeout() {};
    }

    // HTTP basic authentication
    if (config.auth) {
      var username = config.auth.username || '';
      var password = config.auth.password || '';
      requestHeaders.Authorization = 'Basic ' + btoa(username + ':' + password);
    }

    request.open(config.method.toUpperCase(), buildURL(config.url, config.params, config.paramsSerializer), true);

    // Set the request timeout in MS
    request.timeout = config.timeout;

    // Listen for ready state
    request[loadEvent] = function handleLoad() {
      if (!request || (request.readyState !== 4 && !xDomain)) {
        return;
      }

      // The request errored out and we didn't get a response, this will be
      // handled by onerror instead
      // With one exception: request that using file: protocol, most browsers
      // will return status as 0 even though it's a successful request
      if (request.status === 0 && !(request.responseURL && request.responseURL.indexOf('file:') === 0)) {
        return;
      }

      // Prepare the response
      var responseHeaders = 'getAllResponseHeaders' in request ? parseHeaders(request.getAllResponseHeaders()) : null;
      var responseData = !config.responseType || config.responseType === 'text' ? request.responseText : request.response;
      var response = {
        data: responseData,
        // IE sends 1223 instead of 204 (https://github.com/axios/axios/issues/201)
        status: request.status === 1223 ? 204 : request.status,
        statusText: request.status === 1223 ? 'No Content' : request.statusText,
        headers: responseHeaders,
        config: config,
        request: request
      };

      settle(resolve, reject, response);

      // Clean up request
      request = null;
    };

    // Handle low level network errors
    request.onerror = function handleError() {
      // Real errors are hidden from us by the browser
      // onerror should only fire if it's a network error
      reject(createError('Network Error', config, null, request));

      // Clean up request
      request = null;
    };

    // Handle timeout
    request.ontimeout = function handleTimeout() {
      reject(createError('timeout of ' + config.timeout + 'ms exceeded', config, 'ECONNABORTED',
        request));

      // Clean up request
      request = null;
    };

    // Add xsrf header
    // This is only done if running in a standard browser environment.
    // Specifically not if we're in a web worker, or react-native.
    if (utils.isStandardBrowserEnv()) {
      var cookies = __webpack_require__(92);

      // Add xsrf header
      var xsrfValue = (config.withCredentials || isURLSameOrigin(config.url)) && config.xsrfCookieName ?
          cookies.read(config.xsrfCookieName) :
          undefined;

      if (xsrfValue) {
        requestHeaders[config.xsrfHeaderName] = xsrfValue;
      }
    }

    // Add headers to the request
    if ('setRequestHeader' in request) {
      utils.forEach(requestHeaders, function setRequestHeader(val, key) {
        if (typeof requestData === 'undefined' && key.toLowerCase() === 'content-type') {
          // Remove Content-Type if data is undefined
          delete requestHeaders[key];
        } else {
          // Otherwise add header to the request
          request.setRequestHeader(key, val);
        }
      });
    }

    // Add withCredentials to request if needed
    if (config.withCredentials) {
      request.withCredentials = true;
    }

    // Add responseType to request if needed
    if (config.responseType) {
      try {
        request.responseType = config.responseType;
      } catch (e) {
        // Expected DOMException thrown by browsers not compatible XMLHttpRequest Level 2.
        // But, this can be suppressed for 'json' type as it can be parsed by default 'transformResponse' function.
        if (config.responseType !== 'json') {
          throw e;
        }
      }
    }

    // Handle progress if needed
    if (typeof config.onDownloadProgress === 'function') {
      request.addEventListener('progress', config.onDownloadProgress);
    }

    // Not all browsers support upload events
    if (typeof config.onUploadProgress === 'function' && request.upload) {
      request.upload.addEventListener('progress', config.onUploadProgress);
    }

    if (config.cancelToken) {
      // Handle cancellation
      config.cancelToken.promise.then(function onCanceled(cancel) {
        if (!request) {
          return;
        }

        request.abort();
        reject(cancel);
        // Clean up request
        request = null;
      });
    }

    if (requestData === undefined) {
      requestData = null;
    }

    // Send the request
    request.send(requestData);
  });
};

/* WEBPACK VAR INJECTION */}.call(exports, __webpack_require__(28)))

/***/ }),
/* 30 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


var enhanceError = __webpack_require__(87);

/**
 * Create an Error with the specified message, config, error code, request and response.
 *
 * @param {string} message The error message.
 * @param {Object} config The config.
 * @param {string} [code] The error code (for example, 'ECONNABORTED').
 * @param {Object} [request] The request.
 * @param {Object} [response] The response.
 * @returns {Error} The created error.
 */
module.exports = function createError(message, config, code, request, response) {
  var error = new Error(message);
  return enhanceError(error, config, code, request, response);
};


/***/ }),
/* 31 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


module.exports = function isCancel(value) {
  return !!(value && value.__CANCEL__);
};


/***/ }),
/* 32 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


/**
 * A `Cancel` is an object that is thrown when an operation is canceled.
 *
 * @class
 * @param {string=} message The message.
 */
function Cancel(message) {
  this.message = message;
}

Cancel.prototype.toString = function toString() {
  return 'Cancel' + (this.message ? ': ' + this.message : '');
};

Cancel.prototype.__CANCEL__ = true;

module.exports = Cancel;


/***/ }),
/* 33 */
/***/ (function(module, exports, __webpack_require__) {


    var riot = __webpack_require__(0)
    riot.tag2('graphjs-auth-register', '<div class="header" if="{opts.title}"> <div class="title">{opts.title || \'Register\'}</div> </div> <div class="warning" if="{warningMessages.length > 0}"> <ul if="{warningMessages.length > 0}" class="fail"> <li each="{warningMessage in warningMessages}">{warningMessage}</li> </ul> </div> <div class="content"> <form> <input ref="username" type="text" placeholder="Choose a nickname"> <input ref="email" type="text" placeholder="Enter email address"> <input ref="password" type="password" placeholder="Set password"> <input ref="confirmation" type="password" placeholder="Confirm password"> <button ref="submit" onclick="{handleSubmit}">Register</button> <div class="option single"> <a data-link="login" onclick="{opts.minor ? opts.callback : handleLoginBox}">Already a member?</a> </div> </form> </div>', 'graphjs-auth-register{display:block;color:rgba(63,95,127,0.65)}', 'class="{opts.minor != true && \'box\'}"', function(opts) {
'use strict';

var _this = this;

var _register = __webpack_require__(34);

var _register2 = _interopRequireDefault(_register);

var _login = __webpack_require__(14);

var _login2 = _interopRequireDefault(_login);

var _showAlert = __webpack_require__(9);

var _showAlert2 = _interopRequireDefault(_showAlert);

var _showLogin = __webpack_require__(10);

var _showLogin2 = _interopRequireDefault(_showLogin);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

this.handleLoginBox = function () {
    return (0, _showLogin2.default)();
};

this.warningMessages = [];
/*
this.checkUsernameLength = () => {
    let warningMessage = 'Username is too short.';
    let usernameLength = 4;
    if(this.refs.username.value.length >= usernameLength) {
        this.refs.username.classList.remove('error');
        this.warningMessages.includes(warningMessage) && this.warningMessages.splice(this.warningMessages.indexOf(warningMessage), 1);
        return true;
    } else {
        this.refs.username.classList.add('error');
        this.warningMessages.includes(warningMessage) || this.warningMessages.push(warningMessage);
        return false;
    }
}
*/
this.checkUsernamePattern = function () {
    var warningMessage = 'Username is invalid. Valid characters are letters, numbers, hyphens, and underscores.';
    var usernamePattern = /^[a-zA-Z0-9-_]+$/;
    if (usernamePattern.test(_this.refs.username.value)) {
        _this.refs.username.classList.remove('error');
        _this.warningMessages.includes(warningMessage) && _this.warningMessages.splice(_this.warningMessages.indexOf(warningMessage), 1);
        return true;
    } else {
        _this.refs.username.classList.add('error');
        _this.warningMessages.includes(warningMessage) || _this.warningMessages.push(warningMessage);
        return false;
    }
};
this.checkEmailPattern = function () {
    var warningMessage = 'Email is invalid.';
    var emailPattern = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;
    if (emailPattern.test(_this.refs.email.value)) {
        _this.refs.email.classList.remove('error');
        _this.warningMessages.includes(warningMessage) && _this.warningMessages.splice(_this.warningMessages.indexOf(warningMessage), 1);
        return true;
    } else {
        _this.refs.email.classList.add('error');
        _this.warningMessages.includes(warningMessage) || _this.warningMessages.push(warningMessage);
        return false;
    }
};
/*
this.checkPasswordLength = () => {
    let warningMessage = 'Password is too short.';
    let passwordLength = 4;
    if(this.refs.password.value.length >= passwordLength) {
        this.refs.password.classList.remove('error');
        this.warningMessages.includes(warningMessage) && this.warningMessages.splice(this.warningMessages.indexOf(warningMessage), 1);
        return true;
    } else {
        this.refs.password.classList.add('error');
        this.warningMessages.includes(warningMessage) || this.warningMessages.push(warningMessage);
        return false;
    }
}
*/
this.checkPasswordMatch = function () {
    var warningMessage = 'Passwords do not match.';
    if (_this.refs.password.value == _this.refs.confirmation.value) {
        _this.refs.confirmation.classList.remove('error');
        _this.warningMessages.includes(warningMessage) && _this.warningMessages.splice(_this.warningMessages.indexOf(warningMessage), 1);
        return true;
    } else {
        _this.refs.confirmation.classList.add('error');
        _this.warningMessages.includes(warningMessage) || _this.warningMessages.push(warningMessage);
        return false;
    }
};
this.validateForm = function () {
    //let validUsernameLength = this.checkUsernameLength();
    var validUsernamePattern = _this.checkUsernamePattern();
    var validEmailPattern = _this.checkEmailPattern();
    //let validPasswordLength = this.checkPasswordLength();
    var validPasswordMatch = _this.checkPasswordMatch();
    return (
        //validUsernameLength &&
        validUsernamePattern && validEmailPattern &&
        //validPasswordLength &&
        validPasswordMatch ? true : false
    );
};
this.handleSubmit = function (event) {
    var self = _this;
    event.preventDefault();
    _this.validateForm() && (0, _register2.default)(self.refs.username.value, self.refs.email.value, self.refs.password.value, function (response) {
        if (response.success) {
            //Auto-Login
            (0, _login2.default)(self.refs.username.value, self.refs.password.value, function (response) {
                if (response.success) {
                    (0, _showAlert2.default)({
                        title: 'Register Successful!',
                        message: 'You are successfully registered and automatically logged in.'
                    });
                } else {
                    (0, _showAlert2.default)({
                        title: 'Register Successful!',
                        message: 'Please login to continue.',
                        customoption: 'Login',
                        show: 'login',
                        negativeoption: 'Cancel'
                    });
                }
            });
        } else {
            (0, _showAlert2.default)({
                title: 'Register Failed!',
                message: response.reason || 'Please try registering again.',
                customoption: 'Retry',
                show: 'register',
                negativeoption: 'Cancel'
            });
        }
    });
};
});
    
  if (false) {
    module.hot.accept()
    if (module.hot.data) {
      riot.reload('graphjs-auth-register')
    }
  }
  

/***/ }),
/* 34 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


Object.defineProperty(exports, "__esModule", {
	value: true
});

exports.default = function () {
	var args = Array.from(arguments);
	var callback = args.pop();
	registerCall(args, callback);
};

var _api = __webpack_require__(1);

var _api2 = _interopRequireDefault(_api);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function registerCall(args, callback) {
	(0, _api2.default)("signup", {
		"username": args[0],
		"email": args[1],
		"password": args[2]
	}, function (response) {
		callback(response.data);
	});
};

;

/***/ }),
/* 35 */
/***/ (function(module, exports, __webpack_require__) {


    var riot = __webpack_require__(0)
    riot.tag2('graphjs-auth-reset', '<div class="header" if="{opts.title}"> <div class="title">{opts.title || \'Reset Password\'}</div> </div> <div class="warning" if="{warningMessages.length > 0}"> <ul if="{warningMessages.length > 0}" class="fail"> <li each="{warningMessage in warningMessages}">{warningMessage}</li> </ul> </div> <div class="content"> <form> <input ref="email" type="text" placeholder="Enter your email address"> <button onclick="{handleSubmit}">Reset</button> <div class="option single"> <a data-link="register" onclick="{opts.minor ? opts.callback : handleRegisterBox}">Not registered?</a> </div> </form> </div>', 'graphjs-auth-reset{display:block;color:rgba(63,95,127,0.65)}', 'class="{opts.minor != true && \'box\'}"', function(opts) {
'use strict';

var _this = this;

var _reset = __webpack_require__(36);

var _reset2 = _interopRequireDefault(_reset);

var _showAlert = __webpack_require__(9);

var _showAlert2 = _interopRequireDefault(_showAlert);

var _showRegister = __webpack_require__(8);

var _showRegister2 = _interopRequireDefault(_showRegister);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

this.handleRegisterBox = function () {
    return (0, _showRegister2.default)();
};

this.warningMessages = [];
this.checkEmailPattern = function () {
    var warningMessage = 'Email is invalid.';
    var emailPattern = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;
    if (emailPattern.test(_this.refs.email.value)) {
        _this.refs.email.classList.remove('error');
        _this.warningMessages.includes(warningMessage) && _this.warningMessages.splice(_this.warningMessages.indexOf(warningMessage), 1);
        return true;
    } else {
        _this.refs.email.classList.add('error');
        _this.warningMessages.includes(warningMessage) || _this.warningMessages.push(warningMessage);
        return false;
    }
};
this.validateForm = function () {
    var validEmailPattern = _this.checkEmailPattern();
    return validEmailPattern ? true : false;
};
this.handleSubmit = function (event) {
    event.preventDefault();
    _this.validateForm() && (0, _reset2.default)(_this.refs.email.value, function (response) {
        if (response.success) {
            (0, _showAlert2.default)({
                title: 'Email Sent!',
                message: 'An email sent to your email address.'
            });
        } else {
            (0, _showAlert2.default)({
                title: 'Reset Failed!',
                message: response.reason || 'Please try entering your email again.',
                customoption: 'Retry',
                show: 'reset',
                negativeoption: 'Cancel'
            });
        }
    });
};
});
    
  if (false) {
    module.hot.accept()
    if (module.hot.data) {
      riot.reload('graphjs-auth-reset')
    }
  }
  

/***/ }),
/* 36 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


Object.defineProperty(exports, "__esModule", {
	value: true
});

exports.default = function () {
	var args = Array.from(arguments);
	var callback = args.pop();
	resetCall(args, callback);
};

var _api = __webpack_require__(1);

var _api2 = _interopRequireDefault(_api);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function resetCall(args, callback) {
	(0, _api2.default)("remind", {
		"email": args[0]
	}, function (response) {
		callback(response.data);
	});
};

;

/***/ }),
/* 37 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


Object.defineProperty(exports, "__esModule", {
	value: true
});

exports.default = function () {
	var args = Array.from(arguments);
	var callback = args.pop();
	starCall(args, callback);
};

var _api = __webpack_require__(1);

var _api2 = _interopRequireDefault(_api);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function starCall(args, callback) {
	(0, _api2.default)("star", {
		"url": args[0]
	}, function (response) {
		callback(response.data);
	});
};

;

/***/ }),
/* 38 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


Object.defineProperty(exports, "__esModule", {
	value: true
});

exports.default = function () {
	var args = Array.from(arguments);
	var callback = args.pop();
	getStarCall(args, callback);
};

var _api = __webpack_require__(1);

var _api2 = _interopRequireDefault(_api);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function getStarCall(args, callback) {
	(0, _api2.default)("isStarred", {
		"url": args[0]
	}, function (response) {
		callback(response.data);
	});
};

;

/***/ }),
/* 39 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


Object.defineProperty(exports, "__esModule", {
	value: true
});

exports.default = function (callback) {
	getUserStarsCall(callback);
};

var _api = __webpack_require__(1);

var _api2 = _interopRequireDefault(_api);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function getUserStarsCall(callback) {
	(0, _api2.default)("getMyStarredContent", {}, function (response) {
		callback(response.data);
	});
};

;

/***/ }),
/* 40 */
/***/ (function(module, exports, __webpack_require__) {


    var riot = __webpack_require__(0)
    riot.tag2('graphjs-forum-list', '<div class="header"> <div class="title">{opts.title || \'Community Forum\'}</div> </div> <div class="content"> <div class="bar"> <div class="search"> <div class="icon"> <svg viewbox="0 0 20 20" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"> <g transform="translate(-15.000000, -15.000000)" fill="black" fill-rule="nonzero"> <path d="M20.7680925,17.4466286 C17.9916599,20.2182136 17.582728,24.4722742 19.5628195,27.6735622 L15.5811138,31.6483159 C14.8062954,32.4217814 14.8062954,33.6464353 15.5811138,34.4199008 C16.3559322,35.1933664 17.582728,35.1933664 18.3575464,34.4199008 L22.3177294,30.4666324 C25.5246166,32.4217814 29.7861178,32.0350486 32.5625504,29.2634637 C35.8124832,26.0192053 35.8124832,20.7338573 32.5625504,17.4681138 C29.3126177,14.1808851 24.0180253,14.1808851 20.7680925,17.4466286 Z M30.1304816,26.7926709 C28.2149583,28.7048497 25.094162,28.7048497 23.1786387,26.7926709 C21.2631154,24.8804921 21.2631154,21.7651447 23.1786387,19.8529659 C25.094162,17.9407872 28.2149583,17.9407872 30.1304816,19.8529659 C32.0460048,21.7866298 32.0460048,24.8804921 30.1304816,26.7926709 Z" id="Shape" transform="translate(25.000000, 25.000000) scale(-1, 1) translate(-25.000000, -25.000000) "></path> </g> </svg> </div> <input onkeyup="{handleFilter}" type="text" placeholder="Search in posts..."> </div> <button data-link="compose" onclick="{opts.minor ? handleCallback : handleShow}"> <svg viewbox="0 0 21 20" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"> <g transform="translate(-20.000000, -17.000000)" fill="black" fill-rule="nonzero"> <path d="M38.1489476,17 L22.6361271,17 C21.3968108,17 20.3925373,18.0239842 20.3925373,19.2876244 L20.3925373,30.4860904 C20.3925373,31.7497305 21.3968108,32.7737148 22.6361271,32.7737148 L24.7515117,32.7737148 L24.7515117,36.5428483 C24.7515117,36.9132256 25.1574946,37.1310946 25.4566399,36.9132256 L31.4609134,32.7737148 L38.1489476,32.7737148 C39.3882638,32.7737148 40.3925373,31.7497305 40.3925373,30.4860904 L40.3925373,19.2876244 C40.3925373,18.0239842 39.3882638,17 38.1489476,17 Z M31.2728027,25.8802653 L31.2728027,28.6472015 L29.1594735,28.6472015 L29.1594735,25.8802653 L26.3925373,25.8802653 L26.3925373,23.7669362 L29.1594735,23.7669362 L29.1594735,21 L31.2728027,21 L31.2728027,23.7669362 L34.0397388,23.7669362 L34.0397388,25.8802653 L31.2728027,25.8802653 Z"></path> </g> </svg> New Thread </button> </div> <div class="list"> <a each="{matchedThread in matchedThreads}" class="item" data-link="thread" data-id="{matchedThread}" onclick="{opts.minor ? handleCallback : handleShow}" if="{matchedThreads.length > 0}"> <div class="title"> {threadsData[matchedThread] && threadsData[matchedThread].title} </div> <div class="views" if="{threadsData[matchedThread].views}"> <svg viewbox="0 0 19 12" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"> <path transform="translate(0.000000, -19.000000)" d="M18.5059451,24.5206612 C16.1180812,21.0826446 12.8730354,19 9.32185322,19 C5.77067104,19 2.52562526,21.1157025 0.137761378,24.5206612 C-0.0459204592,24.8181818 -0.0459204592,25.1818182 0.137761378,25.4793388 C2.52562526,28.9173554 5.77067104,31 9.32185322,31 C12.8730354,31 16.1180812,28.8842975 18.5059451,25.4793388 C18.7202405,25.1818182 18.7202405,24.785124 18.5059451,24.5206612 Z M13.2403991,25.2479339 C13.1179445,27.3636364 11.5260353,29.0826446 9.56676233,29.214876 C7.2095121,29.3801653 5.25023917,27.2644628 5.40330737,24.7190083 C5.52576192,22.6033058 7.11767118,20.8842975 9.0769441,20.7520661 C11.4341943,20.5867769 13.3934673,22.7024793 13.2403991,25.2479339 Z M11.4341943,25.1157025 C11.3729671,26.2396694 10.5157852,27.1652893 9.47492142,27.231405 C8.18914856,27.3305785 7.14828482,26.1735537 7.24012573,24.8181818 C7.30135301,23.6942149 8.15853492,22.768595 9.19939866,22.7024793 C10.4545579,22.6033058 11.5260353,23.7603306 11.4341943,25.1157025 Z"></path> </svg> {threadsData[matchedThread].views} </div> <time data-time="{threadsData[matchedThread] && threadsData[matchedThread].timestamp}"> {threadsData[matchedThread] && handleTime(threadsData[matchedThread].timestamp)} </time> </a> <div class="placeholder item" if="{matchedThreads.length <= 0}"> There isn\'t any thread available. </div> </div> </div>', 'graphjs-forum-list{display:block;color:rgba(63,95,127,0.65)} graphjs-forum-list .content{padding-top:0 !important;padding-right:0 !important;padding-left:0 !important;padding-bottom:0 !important;padding:0 !important} graphjs-forum-list .content .bar{display:table;width:100%;height:auto} graphjs-forum-list .content .bar>*{float:left;border-radius:0} graphjs-forum-list .content .bar .search{width:80%;border-right:2px solid white;background-color:#3899fa} graphjs-forum-list .content .bar .search>*{float:left;border-radius:0} graphjs-forum-list .content .bar .search .icon{width:3.5em;height:3.5em} graphjs-forum-list .content .bar .search .icon svg{position:relative;width:1.3em;height:1.3em;margin:1.1em;vertical-align:middle} graphjs-forum-list .content .bar .search .icon svg path{fill:white;-webkit-transition:fill .35s ease;-moz-transition:fill .35s ease;-ms-transition:fill .35s ease;-o-transition:fill .35s ease} graphjs-forum-list .content .bar .search input{width:calc(100% - 3.5em);height:3.5em;padding-top:0;padding-right:0;padding-left:0;padding-bottom:0;padding:0;color:white;line-height:3.5em;border:none;background-color:transparent} graphjs-forum-list .content .bar .search input::-webkit-input-placeholder,graphjs-forum-list .content .bar .search input::placeholder{color:rgba(255,255,255,0.75)} graphjs-forum-list .content .bar .search input::-moz-placeholder,graphjs-forum-list .content .bar .search input:-ms-input-placeholder,graphjs-forum-list .content .bar .search input:-moz-placeholder{color:rgba(255,255,255,0.75)} graphjs-forum-list .content .bar .search input:focus::-webkit-input-placeholder,graphjs-forum-list .content .bar .search input:focus::placeholder{opacity:.5} graphjs-forum-list .content .bar .search input:focus::-moz-placeholder,graphjs-forum-list .content .bar .search input:focus:-ms-input-placeholder,graphjs-forum-list .content .bar .search input:focus:-moz-placeholder{opacity:.5} graphjs-forum-list .content .bar button{width:20%;height:3.18181818em;padding-left:0;padding-right:0;font-family:"Rubik";font-weight:400;text-transform:none;background-color:#007fff} graphjs-forum-list .content .bar button:hover{background-color:#198cff} graphjs-forum-list .content .bar button:active{background-color:#0072e6} graphjs-forum-list .content .bar button svg{position:relative;width:auto;height:1.2em;margin-right:.2em;vertical-align:middle} graphjs-forum-list .content .bar button svg path{fill:white;-webkit-transition:fill .35s ease;-moz-transition:fill .35s ease;-ms-transition:fill .35s ease;-o-transition:fill .35s ease} graphjs-forum-list .content .list{display:inline-block;width:100%;height:auto;vertical-align:middle} graphjs-forum-list .content .list .item{display:table;width:100%;color:#6f879f;line-height:3.5em;border-bottom:1px solid rgba(0,0,0,0.1)} graphjs-forum-list .content .list .item:last-child{border-bottom:none} graphjs-forum-list .content .list .item:hover{background-color:rgba(0,127,255,0.05)} graphjs-forum-list .content .list .item.placeholder{color:#9fafbf;text-align:center} graphjs-forum-list .content .list .item>*{float:left} graphjs-forum-list .content .list .item>*:first-child{border-left:none} graphjs-forum-list .content .list .item .title{width:60%;padding:0 1.5em;color:#3f5f7f;overflow:hidden;text-overflow:ellipsis;white-space:nowrap} graphjs-forum-list .content .list .item .views{width:10%;font-size:.9em} graphjs-forum-list .content .list .item .views svg{width:auto;height:.75em;margin-right:.25em} graphjs-forum-list .content .list .item .views svg path{fill:#6f879f} graphjs-forum-list .content .list .item time{width:10%;font-size:.9em} graphjs-forum-list .content .list .item .contributors{width:20%;height:3.5em;padding:.75em 0} graphjs-forum-list .content .list .item .contributors img{width:2em;height:2em;margin-right:.1em;-webkit-border-radius:50%;-moz-border-radius:50%;border-radius:50%;-moz-background-clip:padding;-webkit-background-clip:padding-box;background-clip:padding-box}', 'class="{opts.minor != true && \'box\'}"', function(opts) {
'use strict';

var _this = this;

var _getThreads = __webpack_require__(41);

var _getThreads2 = _interopRequireDefault(_getThreads);

var _showForumCompose = __webpack_require__(42);

var _showForumCompose2 = _interopRequireDefault(_showForumCompose);

var _showForumThread = __webpack_require__(18);

var _showForumThread2 = _interopRequireDefault(_showForumThread);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

this.threads = [];
this.threadsData = {};
this.matchedThreads = [];

this.on('mount', function () {
    var self = this;
    (0, _getThreads2.default)(function (response) {
        if (response.success) {
            for (var _iterator = response.threads, _isArray = Array.isArray(_iterator), _i = 0, _iterator = _isArray ? _iterator : _iterator[Symbol.iterator]();;) {
                var _ref;

                if (_isArray) {
                    if (_i >= _iterator.length) break;
                    _ref = _iterator[_i++];
                } else {
                    _i = _iterator.next();
                    if (_i.done) break;
                    _ref = _i.value;
                }

                var thread = _ref;

                self.threads.push(thread.id);
                self.threadsData[thread.id] = {
                    id: thread.id,
                    title: thread.title,
                    author: thread.author,
                    //views: 1317, //MAKE THIS DYNAMIC
                    timestamp: thread.timestamp,
                    contibutors: thread.contributors //NOT PRINTED FOR NOW
                };
            }
            self.matchedThreads = self.threads;
            self.update();
        } else {
            //Handle error
        }
    });
});

this.handleCallback = function (properties) {
    if (properties.target) {
        properties.preventDefault();
        var dataset = Object.assign({}, properties.currentTarget.dataset);
        opts.callback(dataset);
    } else {
        opts.callback(properties);
    }
};
this.handleShow = function (event) {
    event.preventDefault();
    var dataset = event.currentTarget.dataset;
    switch (dataset.link) {
        case 'compose':
            (0, _showForumCompose2.default)();
            break;
        case 'thread':
            (0, _showForumThread2.default)({
                id: dataset.id
            });
            break;
    }
};
this.handleFilter = function (event) {
    var self = _this;
    self.matchedThreads = self.threads.filter(function (item) {
        return self.threadsData[item].title.startsWith(event.target.value);
    });
};
this.handleTime = function (timestamp) {
    var time = timestamp * 1000;
    var passedTime = Math.floor((Date.now() - time) / 1000);
    var date = new Date(time);
    if (passedTime < 60 * 60 * 24) {
        return date.getHours() + ':' + ((date.getMinutes() < 10 ? '0' : '') + date.getMinutes());
    } else if (passedTime >= 60 * 60 * 24 && passedTime < 60 * 60 * 24 * 365) {
        return _this.months[date.getMonth()].substring(0, 3) + ', ' + date.getDate();
    } else {
        return _this.months[date.getMonth()].substring(0, 3) + ' \'' + date.getFullYear().toString().substring(2, 4);
    }
};
this.months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
});
    
  if (false) {
    module.hot.accept()
    if (module.hot.data) {
      riot.reload('graphjs-forum-list')
    }
  }
  

/***/ }),
/* 41 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


Object.defineProperty(exports, "__esModule", {
	value: true
});

exports.default = function (callback) {
	getThreadsCall(callback);
};

var _api = __webpack_require__(1);

var _api2 = _interopRequireDefault(_api);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function getThreadsCall(callback) {
	(0, _api2.default)("getThreads", {}, function (response) {
		callback(response.data);
	});
};

;

/***/ }),
/* 42 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


Object.defineProperty(exports, "__esModule", {
	value: true
});

exports.default = function (specs) {
	(0, _showOverlay2.default)(tagName, specs);
};

var _showOverlay = __webpack_require__(4);

var _showOverlay2 = _interopRequireDefault(_showOverlay);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

var tagName = 'graphjs-forum-compose';

/***/ }),
/* 43 */
/***/ (function(module, exports, __webpack_require__) {


    var riot = __webpack_require__(0)
    riot.tag2('graphjs-forum-thread', '<div class="header"> <a class="option left" data-link="list" onclick="{opts.minor ? handleCallback : handleShow}"> <svg fill="blue" viewbox="0 0 30 30" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"> <g transform="translate(-15.000000, -15.000000)" fill="black" fill-rule="nonzero"> <path d="M29.9834254,15 C38.2707182,15 45,21.6961326 45,29.9834254 C45,38.2707182 38.2707182,45 29.9834254,45 C21.6961326,45 15,38.2707182 15,29.9834254 C15,21.6961326 21.6961326,15 29.9834254,15 Z M29.9834254,42.3480663 C36.7790055,42.3480663 42.3480663,36.8121547 42.3480663,29.9834254 C42.3480663,23.1878453 36.8121547,17.6187845 29.9834254,17.6187845 C23.1878453,17.6187845 17.6187845,23.1546961 17.6187845,29.9834254 C17.6519337,36.7790055 23.1878453,42.3480663 29.9834254,42.3480663 Z M25.4088398,29.9834254 L31.6077348,36.1823204 L33.4972376,34.2928177 L29.1546961,29.9834254 L33.4972376,25.640884 L31.6077348,23.7513812 L25.4088398,29.9834254 Z"></path> </g> </svg> </a> <div class="title">{opts.title || \'Thread by \' + (currentAuthor || \'Forum User\')}</div> </div> <div class="content"> <div class="thread" ref="scrollingContent"> <div class="title" if="{title}"> <h1>{title}</h1> </div> <div class="replies"> <div each="{entry in entries}" class="item"> <div class="credit" if="{authorsData.hasOwnProperty(entry.author)}"> <img riot-src="{authorsData[entry.author].avatar || \'lib/images/avatars/user.png\'}"> <span> <b>{authorsData[entry.author].username || \'Unknown User\'}</b> <time>{handleTime(entry.timestamp) || \'\'}</time> </span> </div> <p>{entry.content}</p> </div> </div> </div> <div class="reply" if="{entries.length > 0}"> <div onclick="{handleComposer}" class="synopsis"> <b if="{entries.length > 1}">{entries.length < 2 ? (entries.length - 1) + \' reply\' : (entries.length - 1) + \' replies\'}</b> <a>{composerReady ? \'Cancel Reply\' : \'Write a Reply\'}</a> <a class="{composerReady ? \'icon\' : \'reverse icon\'}"> <svg viewbox="0 0 62 38" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"> <path transform="translate(-19.000000, 0.000000)" d="M78.5,2.4 C81.1,5 81.1,9.1 78.5,11.6 L54.6,35.6 C52,38.2 47.9,38.2 45.4,35.6 L21.5,11.7 C18.9,9.1 18.9,5 21.5,2.5 C24.1,-0.1 28.2,-0.1 30.7,2.5 L50,21.7 L69.3,2.4 C71.8,-0.1 76,-0.1 78.5,2.4 Z"></path> </svg> </a> </div> <form> <textarea ref="composer" placeholder="Write your reply here..."></textarea> <button onclick="{handleReply}">Send Reply</button> <button onclick="{handleClear}" class="danger">Clear</button> <form> </div> </div>', 'graphjs-forum-thread{display:block;color:rgba(63,95,127,0.65)} graphjs-forum-thread.composer .content .thread{padding-bottom:18em} graphjs-forum-thread.composer .content .reply{bottom:0} graphjs-forum-thread .content{position:relative;padding-top:0 !important;padding-right:0 !important;padding-left:0 !important;padding-bottom:0 !important;padding:0 !important;vertical-align:middle} graphjs-forum-thread .content .thread{overflow-y:scroll;position:relative;max-height:50em;padding-bottom:3em} graphjs-forum-thread .content .thread .title{position:relative;z-index:2;padding:1.5em 2.5em;line-height:100%;background-color:rgba(255,255,255,0.65);-webkit-box-shadow:0 2px 1px 0 rgba(0,0,0,0.075);-moz-box-shadow:0 2px 1px 0 rgba(0,0,0,0.075);box-shadow:0 2px 1px 0 rgba(0,0,0,0.075)} graphjs-forum-thread .content .thread .title h1{margin-top:0;margin-right:0;margin-left:0;margin-bottom:0;margin:0;color:#3f5f7f;font-family:"Rubik";font-weight:400;font-size:1.75em;line-height:150%} graphjs-forum-thread .content .thread .replies{padding-right:2.5em;padding-left:2.5em;background-color:#f5f7f9} graphjs-forum-thread .content .thread .replies .item{padding:1.5em 0;border-top:1px dotted rgba(0,0,0,0.15)} graphjs-forum-thread .content .thread .replies .item .credit{height:3em;margin-bottom:.25em} graphjs-forum-thread .content .thread .replies .item .credit img{width:3em;height:3em} graphjs-forum-thread .content .thread .replies .item .credit span{color:red;height:3em;margin-left:.6em;padding:.375em 0} graphjs-forum-thread .content .thread .replies .item .credit span b{font-size:1.125em !important} graphjs-forum-thread .content .thread .replies .item .credit span small,graphjs-forum-thread .content .thread .replies .item .credit span time{font-size:.975em !important} graphjs-forum-thread .content .thread .replies .item .credit span{color:#6f879f} graphjs-forum-thread .content .thread .replies .item p{margin-left:48px;font-family:"Rubik";font-weight:400;line-height:150%} graphjs-forum-thread .content .reply{display:inline-block;position:absolute;right:0;bottom:-15em;left:0;width:100%;height:18em;padding:1.5em 2.5em;padding-top:0;border-top:2px solid #007fff;background-color:white;-webkit-box-shadow:0 -2px 1px 0 rgba(0,0,0,0.075);-moz-box-shadow:0 -2px 1px 0 rgba(0,0,0,0.075);box-shadow:0 -2px 1px 0 rgba(0,0,0,0.075)} graphjs-forum-thread .content .reply .synopsis{display:inline-block;position:relative;width:100%;padding:calc(1em - 1px) 0;background-color:white;border-bottom:1px dotted rgba(0,0,0,0.15)} graphjs-forum-thread .content .reply .synopsis>b::after{content:\'\\00b7\';display:inline;margin:0 .25em} graphjs-forum-thread .content .reply .synopsis>a{display:inline-block;height:1em} graphjs-forum-thread .content .reply .synopsis>a.icon{float:right;position:relative;top:.1em} graphjs-forum-thread .content .reply .synopsis>a.icon.reverse{top:-0.1em;-webkit-transform:scaleY(-1);-moz-transform:scaleY(-1);-ms-transform:scaleY(-1);-o-transform:scaleY(-1)} graphjs-forum-thread .content .reply .synopsis>a.icon svg{width:auto;height:.8em;padding:.1em 0} graphjs-forum-thread .content .reply .synopsis>a.icon svg path{fill:#007fff} graphjs-forum-thread .content .reply form textarea{width:100%;height:9em;margin-top:1em;padding-top:0;padding-right:0;padding-left:0;padding-bottom:0;padding:0;line-height:150%;border:none} graphjs-forum-thread .content .reply form textarea.closed{height:0;border:none} graphjs-forum-thread .content .reply form button{float:right;width:auto;margin-top:.5em;margin-left:.5em;font-size:.9em}', '', function(opts) {
'use strict';

var _this = this;

var _getThread = __webpack_require__(44);

var _getThread2 = _interopRequireDefault(_getThread);

var _replyThread = __webpack_require__(45);

var _replyThread2 = _interopRequireDefault(_replyThread);

var _showForumList = __webpack_require__(19);

var _showForumList2 = _interopRequireDefault(_showForumList);

var _getProfile = __webpack_require__(7);

var _getProfile2 = _interopRequireDefault(_getProfile);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

this.id = opts.id;
this.entries = [];
this.authorsData = {};
this.composerReady = false;

this.on('mount', function () {
    opts.minor || this.root.classList.add('box');
    this.handleContent();
});

this.handleContent = function (callback) {
    var self = _this;
    self.id && (0, _getThread2.default)(self.id, function (response) {
        if (response.success) {
            self.title = response.title;
            self.entries = response.messages;
            self.update();
            callback && callback();

            var _loop = function _loop() {
                if (_isArray) {
                    if (_i >= _iterator.length) return 'break';
                    _ref = _iterator[_i++];
                } else {
                    _i = _iterator.next();
                    if (_i.done) return 'break';
                    _ref = _i.value;
                }

                var entry = _ref;

                (0, _getProfile2.default)(entry.author, function (response) {
                    if (response.success) {
                        self.currentAuthor = self.currentAuthor || response.profile.username;
                        self.authorsData[entry.author] = response.profile;
                    }
                    self.update();
                });
            };

            for (var _iterator = self.entries, _isArray = Array.isArray(_iterator), _i = 0, _iterator = _isArray ? _iterator : _iterator[Symbol.iterator]();;) {
                var _ref;

                var _ret = _loop();

                if (_ret === 'break') break;
            }
            self.update();
        }
    });
};
this.handleComposer = function () {
    _this.root.classList.toggle('composer');
    if (_this.composerReady) {
        _this.composerReady = false;
        _this.refs.composer.value = '';
    } else {
        _this.composerReady = true;
        _this.refs.composer.focus();
    }
};
this.handleClear = function (event) {
    event.preventDefault();
    _this.refs.composer.value = '';
    _this.refs.composer.focus();
};
this.handleReply = function (event) {
    event.preventDefault();
    var self = _this;
    (0, _replyThread2.default)(self.id, self.refs.composer.value, function (response) {
        if (response.success) {
            self.handleContent();
            self.composerReady = false;
            self.refs.composer.value = '';
            self.root.classList.toggle('composer');
            self.update();
        } else {
            //Handle error
        }
    });
};
this.handleCallback = function (properties) {
    if (properties.target) {
        properties.preventDefault();
        var dataset = Object.assign({}, properties.currentTarget.dataset);
        opts.callback(dataset);
    } else {
        opts.callback(properties);
    }
};
this.handleShow = function (event) {
    event.preventDefault();
    var dataset = event.currentTarget.dataset;
    switch (dataset.link) {
        case 'list':
            (0, _showForumList2.default)();
            break;
    }
};
this.handleTime = function (timestamp) {
    var date = new Date(parseInt(timestamp) * 1000);
    var day = date.getDate();
    var month = _this.months[date.getMonth()];
    var year = date.getFullYear();
    var hour = date.getHours();
    var minute = date.getMinutes();
    return month + ' ' + day + ', ' + year + ' · ' + hour + ':' + minute;
};
this.months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
});
    
  if (false) {
    module.hot.accept()
    if (module.hot.data) {
      riot.reload('graphjs-forum-thread')
    }
  }
  

/***/ }),
/* 44 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


Object.defineProperty(exports, "__esModule", {
	value: true
});

exports.default = function () {
	var args = Array.from(arguments);
	var callback = args.pop();
	getThreadCall(args, callback);
};

var _api = __webpack_require__(1);

var _api2 = _interopRequireDefault(_api);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function getThreadCall(args, callback) {
	(0, _api2.default)("getThread", {
		"id": args[0]
	}, function (response) {
		callback(response.data);
	});
};

;

/***/ }),
/* 45 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


Object.defineProperty(exports, "__esModule", {
	value: true
});

exports.default = function () {
	var args = Array.from(arguments);
	var callback = args.pop();
	replyThreadCall(args, callback);
};

var _api = __webpack_require__(1);

var _api2 = _interopRequireDefault(_api);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function replyThreadCall(args, callback) {
	(0, _api2.default)("reply", {
		"id": args[0],
		"message": args[1]
	}, function (response) {
		callback(response.data);
	});
};

;

/***/ }),
/* 46 */
/***/ (function(module, exports, __webpack_require__) {


    var riot = __webpack_require__(0)
    riot.tag2('graphjs-forum-compose', '<div class="header"> <div class="title">{opts.title || \'New Thread\'}</div> <a class="option right" data-link="list" onclick="{opts.minor ? handleCallback : handleShow}"> <svg viewbox="0 0 30 30" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"> <g transform="translate(-755.000000, -15.000000)" fill="black" fill-rule="nonzero"> <path d="M768.138179,30.0276818 L763.8,25.6895028 L765.689503,23.8 L770.011119,28.1447263 L774.332735,23.8 L776.222238,25.6895028 L771.884059,30.0276818 L771.888398,30.0320442 L771.884064,30.0363784 L776.222238,34.3414365 L774.332735,36.2309392 L770.011119,31.9093232 L765.689503,36.2309392 L763.8,34.3414365 L768.138174,30.0363784 L768.13384,30.0320442 L768.138179,30.0276818 Z M769.983425,15 C778.270718,15 785,21.6961326 785,29.9834254 C785,38.2707182 778.270718,45 769.983425,45 C761.696133,45 755,38.2707182 755,29.9834254 C755,21.6961326 761.696133,15 769.983425,15 Z M769.983425,42.3480663 C776.779006,42.3480663 782.348066,36.8121547 782.348066,29.9834254 C782.348066,23.1878453 776.812155,17.6187845 769.983425,17.6187845 C763.187845,17.6187845 757.618785,23.1546961 757.618785,29.9834254 C757.651934,36.7790055 763.187845,42.3480663 769.983425,42.3480663 Z"></path> </g> </svg> </a> </div> <div class="warning" if="{warningMessages.length > 0}"> <ul if="{warningMessages.length > 0}" class="fail"> <li each="{warningMessage in warningMessages}">{warningMessage}</li> </ul> </div> <div class="content"> <form> <input ref="title" type="text" placeholder="Enter your post title here..."> <textarea ref="body" placeholder="Compose your post here..."></textarea> <span> <b>Supported formats:</b> Markdown </span> <button data-link="thread" onclick="{handleSubmit}">Publish</button> <button data-link="list" onclick="{opts.minor ? handleCallback : handleShow}" class="danger">Cancel</button> </form> </div>', 'graphjs-forum-compose{display:block;color:rgba(63,95,127,0.65)} graphjs-forum-compose .content form::after{content:"";display:table;clear:both} graphjs-forum-compose .content form input{width:60%} graphjs-forum-compose .content form textarea{height:21.5em;line-height:1.25em} graphjs-forum-compose .content form button{width:20%;float:right;margin-left:.5em;font-size:.95em} graphjs-forum-compose .content form span{float:left;max-width:55%;line-height:1.5em}', 'class="{opts.minor != true && \'box\'}"', function(opts) {
'use strict';

var _this = this;

var _startThread = __webpack_require__(47);

var _startThread2 = _interopRequireDefault(_startThread);

var _showForumList = __webpack_require__(19);

var _showForumList2 = _interopRequireDefault(_showForumList);

var _showForumThread = __webpack_require__(18);

var _showForumThread2 = _interopRequireDefault(_showForumThread);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

this.warningMessages = [];
this.checkTitle = function () {
    var warningMessage = 'Title is too short.';
    if (_this.refs.title.value.length >= 10) {
        _this.refs.title.classList.remove('error');
        _this.warningMessages.includes(warningMessage) && _this.warningMessages.splice(_this.warningMessages.indexOf(warningMessage), 1);
        return true;
    } else {
        _this.refs.title.classList.add('error');
        _this.warningMessages.includes(warningMessage) || _this.warningMessages.push(warningMessage);
        return false;
    }
};
this.checkTextBody = function () {
    var warningMessage = 'Text body is too short.';
    if (_this.refs.body.value.length >= 10) {
        _this.refs.body.classList.remove('error');
        _this.warningMessages.includes(warningMessage) && _this.warningMessages.splice(_this.warningMessages.indexOf(warningMessage), 1);
        return true;
    } else {
        _this.refs.body.classList.add('error');
        _this.warningMessages.includes(warningMessage) || _this.warningMessages.push(warningMessage);
        return false;
    }
};
this.validateForm = function () {
    var validTitle = _this.checkTitle();
    var validTextBody = _this.checkTextBody();
    return validTitle && validTextBody ? true : false;
};
this.handleSubmit = function (event) {
    event.preventDefault();
    var self = _this;
    _this.validateForm() && (0, _startThread2.default)(self.refs.title.value, self.refs.body.value, function (response) {
        if (opts.minor) {
            if (response.success) {
                self.handleCallback({
                    link: 'thread',
                    id: response.id
                });
            } else {
                //Handle error
            }
        } else {
            if (response.success) {
                (0, _showForumThread2.default)({
                    id: response.id
                });
            } else {
                //Handle error
            }
        }
    });
};
this.handleCallback = function (properties) {
    if (properties.target) {
        properties.preventDefault();
        var dataset = Object.assign({}, properties.currentTarget.dataset);
        opts.callback(dataset);
    } else {
        opts.callback(properties);
    }
};
this.handleShow = function (event) {
    event.preventDefault();
    var dataset = event.currentTarget.dataset;
    switch (dataset.link) {
        case 'list':
            (0, _showForumList2.default)();
            break;
        case 'thread':
            (0, _showForumThread2.default)({
                id: dataset.id
            });
            break;
    }
};
});
    
  if (false) {
    module.hot.accept()
    if (module.hot.data) {
      riot.reload('graphjs-forum-compose')
    }
  }
  

/***/ }),
/* 47 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


Object.defineProperty(exports, "__esModule", {
	value: true
});

exports.default = function () {
	var args = Array.from(arguments);
	var callback = args.pop();
	startThreadCall(args, callback);
};

var _api = __webpack_require__(1);

var _api2 = _interopRequireDefault(_api);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function startThreadCall(args, callback) {
	(0, _api2.default)("startThread", {
		"title": args[0],
		"message": args[1]
	}, function (response) {
		callback(response.data);
	});
};

;

/***/ }),
/* 48 */
/***/ (function(module, exports, __webpack_require__) {


    var riot = __webpack_require__(0)
    riot.tag2('graphjs-group-header', '<div class="information" if="{group}"> <div class="cover" riot-style="{\'background-image: url(\' + (group.cover ? \'https://\' + group.id + \'.png\' : \'lib/images/covers/group.png\') + \');\'}"></div> <a>{group.title}</a> <p>{group.description}</p> <button onclick="{joined ? handleLeave : handleJoin}"> {joined ? \'Leave Group\' : \'Join Group\'} <span if="{group.count}">{group.count}</span> </button> </div> <div class="information" if="{!group}"> <div class="cover" style="background-image: url(lib/images/covers/group.png)"></div> <a>Group doesn\'t exist.</a> <p>We couldn\'t find any group matching this id.</p> <button onclick="{handleUpdate}">Refresh</button> </div>', 'graphjs-group-header{display:block;width:100%;color:rgba(63,95,127,0.65);text-align:center} graphjs-group-header+*{margin-top:1.5em} graphjs-group-header .information{height:auto} graphjs-group-header .information .cover{display:block;width:100%;height:15em;background-position:center;background-size:cover} graphjs-group-header .information a{display:inline-block;overflow:hidden;width:90%;max-height:2.5em;margin:0 5%;margin-top:1.5em;font-size:1.2em;line-height:1.25em;font-family:"Rubik";font-weight:800;color:#007fff} graphjs-group-header .information a:hover{color:#198cff} graphjs-group-header .information a:active{color:#0072e6} graphjs-group-header .information p{display:inline-block;overflow:hidden;width:90%;max-height:2.5em;margin:0 5%;margin-top:.75em;color:#6f879f;line-height:1.25em} graphjs-group-header .information button{display:inline-block;position:relative;width:auto;height:2.5em;margin:1.5em auto;padding-right:3.5em} graphjs-group-header .information button span{display:block;position:absolute;top:0;right:0;bottom:0;width:2.5em;height:100%;line-height:2.5em;vertical-align:middle;border-left:1px dotted white;background-color:rgba(0,0,0,0.1)} graphjs-group-header ul{margin:0;padding:0;font-size:0;-webkit-border-radius:0;-moz-border-radius:0;border-radius:0;-moz-background-clip:padding;-webkit-background-clip:padding-box;background-clip:padding-box;background-color:#007fff;list-style:none} graphjs-group-header ul li{display:inline-block;background-color:transparent;-webkit-transition:background-color .35s ease;-moz-transition:background-color .35s ease;-ms-transition:background-color .35s ease;-o-transition:background-color .35s ease} graphjs-group-header ul li:hover{background-color:rgba(0,0,0,0.2)} graphjs-group-header ul li.active{background-color:rgba(0,0,0,0.2)} graphjs-group-header ul li.active a{opacity:1} graphjs-group-header ul li a{display:inline-block;opacity:.85;padding:0 1em;cursor:pointer;color:white;font-size:15.4px;font-family:"Rubik";font-weight:700;line-height:2.5em} graphjs-group-header.color .option svg path{fill:white} graphjs-group-header.color .information img{border:4px solid white}', 'class="box"', function(opts) {
'use strict';

var _this = this;

var _getGroup = __webpack_require__(49);

var _getGroup2 = _interopRequireDefault(_getGroup);

var _joinGroup = __webpack_require__(20);

var _joinGroup2 = _interopRequireDefault(_joinGroup);

var _leaveGroup = __webpack_require__(50);

var _leaveGroup2 = _interopRequireDefault(_leaveGroup);

var _showGroup = __webpack_require__(21);

var _showGroup2 = _interopRequireDefault(_showGroup);

var _getUser = __webpack_require__(6);

var _getUser2 = _interopRequireDefault(_getUser);

var _listMembers = __webpack_require__(12);

var _listMembers2 = _interopRequireDefault(_listMembers);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

this.id = opts.id;
this.userId = undefined;

this.on('before-mount', function () {
    this.handleInformation();
    this.handleMembers();
});
this.on('mount', function () {
    opts.theme && this.root.classList.add(opts.theme);
});

this.handleInformation = function () {
    var self = _this;
    (0, _getGroup2.default)(self.id, function (response) {
        if (response.success) {
            self.group = response.group;
            self.update();
        } else {
            //Handle errors
        }
    });
};
this.handleMembers = function () {
    var self = _this;
    (0, _listMembers2.default)(self.id, function (response) {
        if (response.success) {
            self.members = response.members;
            self.update();
            (0, _getUser2.default)(function (response) {
                if (response.success) {
                    self.joined = self.members.includes(response.id);
                    self.update();
                } else {
                    //Handle errors
                }
            });
        } else {
            //Handle errors
        }
    });
};
this.handleJoin = function () {
    var self = _this;
    (0, _joinGroup2.default)(self.id, function (response) {
        if (response.success) {
            self.joined = true;
            self.handleInformation();
            self.update();
        } else {
            //Handle errors
        }
    });
};
this.handleLeave = function () {
    var self = _this;
    (0, _leaveGroup2.default)(self.id, function (response) {
        if (response.success) {
            self.joined = false;
            self.handleInformation();
            self.update();
        } else {
            //Handle errors
        }
    });
};
this.handleUpdate = function () {
    return _this.update();
};
});
    
  if (false) {
    module.hot.accept()
    if (module.hot.data) {
      riot.reload('graphjs-group-header')
    }
  }
  

/***/ }),
/* 49 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


Object.defineProperty(exports, "__esModule", {
	value: true
});

exports.default = function () {
	var args = Array.from(arguments);
	var callback = args.pop();
	getGroupCall(args, callback);
};

var _api = __webpack_require__(1);

var _api2 = _interopRequireDefault(_api);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function getGroupCall(args, callback) {
	(0, _api2.default)("getGroup", {
		"id": args[0]
	}, function (response) {
		callback(response.data);
	});
};

;

/***/ }),
/* 50 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


Object.defineProperty(exports, "__esModule", {
	value: true
});

exports.default = function () {
	var args = Array.from(arguments);
	var callback = args.pop();
	leaveGroupCall(args, callback);
};

var _api = __webpack_require__(1);

var _api2 = _interopRequireDefault(_api);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function leaveGroupCall(args, callback) {
	(0, _api2.default)("leave", {
		"id": args[0]
	}, function (response) {
		callback(response.data);
	});
};

;

/***/ }),
/* 51 */
/***/ (function(module, exports, __webpack_require__) {


    var riot = __webpack_require__(0)
    riot.tag2('graphjs-group-activity', '<h1>activity</h1>', '', '', function(opts) {
});
    
  if (false) {
    module.hot.accept()
    if (module.hot.data) {
      riot.reload('graphjs-group-activity')
    }
  }
  

/***/ }),
/* 52 */
/***/ (function(module, exports, __webpack_require__) {


    var riot = __webpack_require__(0)
    riot.tag2('graphjs-group-members', '<div class="content"> <graphjs-profile-card each="{id in list}" id="{id}"></graphjs-profile-card> </div>', '', 'class="wallet"', function(opts) {
'use strict';

var _listMembers = __webpack_require__(12);

var _listMembers2 = _interopRequireDefault(_listMembers);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

this.id = opts.id;
this.list = [];

this.on('before-mount', function () {
    var self = this;
    (0, _listMembers2.default)(self.id, function (response) {
        if (response.success) {
            self.list = response.members;
            self.update();
        } else {
            //Handle error
        }
    });
});
});
    
  if (false) {
    module.hot.accept()
    if (module.hot.data) {
      riot.reload('graphjs-group-members')
    }
  }
  

/***/ }),
/* 53 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


Object.defineProperty(exports, "__esModule", {
	value: true
});

exports.default = function (callback) {
	getConversationsCall(callback);
};

var _api = __webpack_require__(1);

var _api2 = _interopRequireDefault(_api);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function getConversationsCall(callback) {
	(0, _api2.default)("getConversations", {}, function (response) {
		callback(response.data);
	});
};

;

/***/ }),
/* 54 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


Object.defineProperty(exports, "__esModule", {
	value: true
});

exports.default = function () {
	var args = Array.from(arguments);
	var callback = args.pop();
	getConversationCall(args, callback);
};

var _api = __webpack_require__(1);

var _api2 = _interopRequireDefault(_api);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function getConversationCall(args, callback) {
	(0, _api2.default)("getConversation", {
		"with": args[0]
	}, function (response) {
		callback(response.data);
	});
};

;

/***/ }),
/* 55 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


Object.defineProperty(exports, "__esModule", {
	value: true
});

exports.default = function () {
	var args = Array.from(arguments);
	var callback = args.pop();
	sendMessageCall(args, callback);
};

var _api = __webpack_require__(1);

var _api2 = _interopRequireDefault(_api);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function sendMessageCall(args, callback) {
	(0, _api2.default)("sendMessage", {
		"to": args[0],
		"message": args[1]
	}, function (response) {
		callback(response.data);
	});
};

;

/***/ }),
/* 56 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


Object.defineProperty(exports, "__esModule", {
	value: true
});

exports.default = function (callback) {
	getMembersCall(callback);
};

var _api = __webpack_require__(1);

var _api2 = _interopRequireDefault(_api);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function getMembersCall(callback) {
	(0, _api2.default)("getMembers", {}, function (response) {
		callback(response.data);
	});
};

;

/***/ }),
/* 57 */
/***/ (function(module, exports, __webpack_require__) {


    var riot = __webpack_require__(0)
    riot.tag2('graphjs-profile-header', '<a class="left option" onclick="{handleFollow}" if="{profile}"> <svg viewbox="0 0 24 20" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"> <g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd"> <g transform="translate(-22.000000, -20.000000)" fill="black" fill-rule="nonzero"> <path d="M22,39.0597068 L22,37.9313549 C22,36.9492708 22.4486148,36.0089776 23.2390314,35.4239063 C25.5461933,33.6686922 27.8960803,32.4985495 28.3874204,32.2687001 C28.4515082,32.2478047 28.4942334,32.1851185 28.4942334,32.1224322 L28.4942334,30.7224401 C28.1310691,30.1164733 27.917443,29.426925 27.8319925,28.8209582 C27.6183664,28.8000628 27.3192899,28.5075271 27.0202133,27.4418615 C26.5929611,25.9791831 27.0415759,25.7702291 27.4261029,25.7911245 C27.148389,25.0179945 27.148389,24.2657599 27.3192899,23.5762115 C27.5115534,22.7612907 27.9601682,22.0926377 28.4728708,21.591148 C28.79331,21.2568215 29.1564743,20.9642859 29.5410013,20.713541 C29.8614405,20.5045869 30.2032422,20.3165283 30.5877692,20.1911559 C30.8868457,20.0866788 31.2072849,20.0239926 31.527724,20.0239926 C32.5744919,19.9195156 33.3649085,20.1702605 33.9203363,20.5045869 C34.7534781,20.9642859 35.0739173,21.5493572 35.0739173,21.5493572 C35.0739173,21.5493572 37.1888157,21.695625 36.2702234,26.0209739 C36.5479374,26.1254509 36.7615635,26.5015682 36.4197617,27.6299201 C36.0138721,29.0299123 35.6507078,29.1134939 35.415719,28.9672261 C35.3302686,29.4478204 35.1807303,29.9911009 34.924379,30.4925906 C34.924379,31.2030344 34.924379,31.850792 34.924379,32.1015368 C34.924379,32.164223 34.9671042,32.2269093 35.0311921,32.2478047 C35.5438947,32.4985495 37.8937818,33.6686922 40.2009437,35.4239063 C40.9913602,36.029873 41.439975,36.9492708 41.439975,37.9313549 L41.439975,39.0597068 C41.439975,39.5820919 41.0127228,40 40.4786576,40 L22.9399548,40 C22.4272522,39.9791046 22,39.5611965 22,39.0597068 Z M37.7770946,28.6529954 L39.0022126,28.6665402 L40.0181642,28.6777726 L39.993387,26.4367029 C39.9857886,25.7494416 40.5176988,25.2175314 41.2049602,25.2251298 C41.8922215,25.2327281 42.4360248,25.7765314 42.4436231,26.4637927 L42.4684003,28.7048623 L44.70947,28.7296396 C45.3967313,28.7372379 45.9405346,29.2810412 45.9481329,29.9683025 C45.9557313,30.6555639 45.4238211,31.187474 44.7365597,31.1798757 L42.4954901,31.1550985 L42.5067224,32.17105 L42.5202673,33.3961681 C42.5278657,34.0834295 41.9959555,34.6153396 41.3086941,34.6077413 C40.6214328,34.6001429 40.0776295,34.0563397 40.0700312,33.3690783 L40.0564863,32.1439603 L40.045254,31.1280087 L39.0293024,31.1167764 L37.8041843,31.1032315 C37.116923,31.0956331 36.5731197,30.5518299 36.5655214,29.8645685 C36.557923,29.1773072 37.0898332,28.645397 37.7770946,28.6529954 Z"></path> </g> </g> </svg> </a> <a class="right option" onclick="{handleMessagesBox}" if="{profile}"> <svg viewbox="0 0 50 48" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"> <g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd"> <path d="M34.8236776,11.6342064 L4.78589421,11.6342064 C2.14105793,11.6342064 0,13.7752644 0,16.4201006 L0,36.0044835 C0,38.6493198 2.14105793,40.7903777 4.78589421,40.7903777 L19.5843829,40.7903777 L31.3602015,47.7803022 L30.7934509,40.7903777 L34.8866499,40.7903777 C37.5314861,40.7903777 39.6725441,38.6493198 39.6725441,36.0044835 L39.6725441,16.4201006 C39.6725441,13.7752644 37.4685139,11.6342064 34.8236776,11.6342064 Z M10.5478586,29.1405026 C9.22544054,29.1405026 8.12342545,28.0384875 8.12342545,26.7160694 C8.12342545,25.3936513 9.22544054,24.2916362 10.5478586,24.2916362 C11.8702767,24.2916362 12.9722918,25.3936513 12.9722918,26.7160694 C12.9722918,28.0384875 11.8702767,29.1405026 10.5478586,29.1405026 Z M19.8677586,29.1405026 C18.5453405,29.1405026 17.4433254,28.0384875 17.4433254,26.7160694 C17.4433254,25.3936513 18.5453405,24.2916362 19.8677586,24.2916362 C21.1901767,24.2916362 22.2921918,25.3936513 22.2921918,26.7160694 C22.2187241,28.0384875 21.1901767,29.1405026 19.8677586,29.1405026 Z M29.124686,29.1405026 C27.8022679,29.1405026 26.7002529,28.0384875 26.7002529,26.7160694 C26.7002529,25.3936513 27.8022679,24.2916362 29.124686,24.2916362 C30.4471041,24.2916362 31.5491192,25.3936513 31.5491192,26.7160694 C31.5491192,28.0384875 30.4471041,29.1405026 29.124686,29.1405026 Z M45.2141058,0.779999733 C47.8589421,0.779999733 50,2.9210577 50,5.56589402 L50,25.0873049 C50,27.7321412 47.8589421,29.8731992 45.2141058,29.8731992 L42.3803526,29.8731992 L42.4433249,16.523073 C42.4433249,12.3039294 39.0428212,8.90342556 34.8236776,8.90342556 L10.3904282,8.90342556 L10.3904282,5.56589402 C10.3904282,2.9210577 12.5314861,0.779999733 15.1763224,0.779999733 L45.2141058,0.779999733 Z"></path> </g> </svg> </a> <div class="information" if="{profile}"> <img riot-src="{profile.avatar || \'lib/images/avatars/user.png\'}"> <a>{profile.fullName || profile.username}</a> <p>{profile.about}</p> </div> <div class="information" if="{!profile}"> <img src="lib/images/avatars/user.png"> <a>User doesn\'t exist.</a> <p>We couldn\'t find any user matching this id.</p> </div> <ul if="{profile}"> <li class="{opts.active == \'followers\' ? \'active\' : \'\'}"> <a data-link="followers" onclick="{opts.callback;}">Followers</a> </li> <li class="{opts.active == \'following\' ? \'active\' : \'\'}"> <a data-link="following" onclick="{opts.callback;}">Following</a> </li> <li class="{opts.active == \'groups\' ? \'active\' : \'\'}"> <a data-link="groups" onclick="{opts.callback;}">Groups</a> </li> <li if="{userId == id}" class="{opts.active == \'settings\' ? \'active\' : \'\'}"> <a data-link="settings" onclick="{opts.callback;}">Settings</a> </li> </ul> <button if="{!profile}" onclick="{handleUpdate}">Refresh</button>', 'graphjs-profile-header{display:block;width:100%;color:rgba(63,95,127,0.65);text-align:center} graphjs-profile-header+*{margin-top:1.5em} graphjs-profile-header .option{display:inline-block;width:3.75em;height:3.75em;padding:1em;text-align:center} graphjs-profile-header .option svg path{fill:#007fff} graphjs-profile-header .option:hover svg path{fill:#198cff} graphjs-profile-header .option:active svg path{fill:#0072e6} graphjs-profile-header .option.left{float:left} graphjs-profile-header .option.right{float:right} graphjs-profile-header .option svg{position:relative;max-width:1.5em;max-height:auto;vertical-align:middle} graphjs-profile-header .option svg path{fill:#007fff;-webkit-transition:fill .35s ease;-moz-transition:fill .35s ease;-ms-transition:fill .35s ease;-o-transition:fill .35s ease} graphjs-profile-header .information{height:15em;padding-top:2em} graphjs-profile-header .information img{width:6.5em;height:6.5em;border:4px solid rgba(63,95,127,0.15);-webkit-border-radius:50%;-moz-border-radius:50%;border-radius:50%;-moz-background-clip:padding;-webkit-background-clip:padding-box;background-clip:padding-box} graphjs-profile-header .information a{display:inline-block;overflow:hidden;width:90%;max-height:2.5em;margin:0 5%;margin-top:.5em;font-size:1.2em;line-height:1.25em;font-family:"Rubik";font-weight:800;color:#007fff} graphjs-profile-header .information a:hover{color:#198cff} graphjs-profile-header .information a:active{color:#0072e6} graphjs-profile-header .information p{display:inline-block;overflow:hidden;width:90%;max-height:2.5em;margin:0 5%;margin-top:.75em;color:#6f879f;line-height:1.25em} graphjs-profile-header ul{margin:0;padding:0;font-size:0;-webkit-border-radius:0;-moz-border-radius:0;border-radius:0;-moz-background-clip:padding;-webkit-background-clip:padding-box;background-clip:padding-box;background-color:#007fff;list-style:none} graphjs-profile-header ul li{display:inline-block;background-color:transparent;-webkit-transition:background-color .35s ease;-moz-transition:background-color .35s ease;-ms-transition:background-color .35s ease;-o-transition:background-color .35s ease} graphjs-profile-header ul li:hover{background-color:rgba(0,0,0,0.2)} graphjs-profile-header ul li.active{background-color:rgba(0,0,0,0.2)} graphjs-profile-header ul li.active a{opacity:1} graphjs-profile-header ul li a{display:inline-block;opacity:.85;padding:0 1em;cursor:pointer;color:white;font-size:15.4px;font-family:"Rubik";font-weight:700;line-height:2.5em} graphjs-profile-header.color .option svg path{fill:white} graphjs-profile-header.color .information img{border:4px solid white}', 'class="box"', function(opts) {
'use strict';

var _this = this;

var _getProfile = __webpack_require__(7);

var _getProfile2 = _interopRequireDefault(_getProfile);

var _getUser = __webpack_require__(6);

var _getUser2 = _interopRequireDefault(_getUser);

var _showMessages = __webpack_require__(11);

var _showMessages2 = _interopRequireDefault(_showMessages);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

this.id = opts.id;
this.userId = undefined;

this.on('before-mount', function () {
    this.handleInformation(this.id);
    this.handleUser();
});
this.on('mount', function () {
    opts.theme && this.root.classList.add(opts.theme);
});

this.handleUser = function () {
    var self = _this;
    (0, _getUser2.default)(function (response) {
        if (response.success) {
            self.userId = response.id;
            self.update();
        } else {
            //Handle errors
        }
    });
};
this.handleMessagesBox = function () {
    return (0, _showMessages2.default)();
};
this.handleFollow = function () {
    //Follow the user
};
this.handleInformation = function (id) {
    var self = _this;
    (0, _getProfile2.default)(id, function (response) {
        if (response.success) {
            self.profile = response.profile;
            self.update();
        } else {
            //Handle errors
        }
    });
};
this.handleUpdate = function () {
    return _this.update();
};
});
    
  if (false) {
    module.hot.accept()
    if (module.hot.data) {
      riot.reload('graphjs-profile-header')
    }
  }
  

/***/ }),
/* 58 */
/***/ (function(module, exports, __webpack_require__) {


    var riot = __webpack_require__(0)
    riot.tag2('graphjs-profile-activity', '<h1>activity</h1>', '', '', function(opts) {
});
    
  if (false) {
    module.hot.accept()
    if (module.hot.data) {
      riot.reload('graphjs-profile-activity')
    }
  }
  

/***/ }),
/* 59 */
/***/ (function(module, exports, __webpack_require__) {


    var riot = __webpack_require__(0)
    riot.tag2('graphjs-profile-followers', '<div class="content"> <graphjs-profile-card each="{id in list}" id="{id}"></graphjs-profile-card> </div>', '', 'class="wallet"', function(opts) {
'use strict';

var _getFollowers = __webpack_require__(60);

var _getFollowers2 = _interopRequireDefault(_getFollowers);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

this.id = opts.id;
this.list = [];

this.on('before-mount', function () {
    var self = this;
    (0, _getFollowers2.default)(self.id, function (response) {
        if (response.success) {
            self.list = Object.keys(response.followers);
            self.update();
        } else {
            //Handle error
        }
    });
});
});
    
  if (false) {
    module.hot.accept()
    if (module.hot.data) {
      riot.reload('graphjs-profile-followers')
    }
  }
  

/***/ }),
/* 60 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


Object.defineProperty(exports, "__esModule", {
	value: true
});

exports.default = function () {
	var args = Array.from(arguments);
	var callback = args.pop();
	getFollowersCall(args, callback);
};

var _api = __webpack_require__(1);

var _api2 = _interopRequireDefault(_api);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function getFollowersCall(args, callback) {
	(0, _api2.default)("getFollowers", {
		"id": args[0]
	}, function (response) {
		callback(response.data);
	});
};

;

/***/ }),
/* 61 */
/***/ (function(module, exports, __webpack_require__) {


    var riot = __webpack_require__(0)
    riot.tag2('graphjs-profile-following', '<div class="content"> <graphjs-profile-card each="{id in list}" id="{id}"></graphjs-profile-card> </div>', '', 'class="wallet"', function(opts) {
'use strict';

var _getFollowing = __webpack_require__(62);

var _getFollowing2 = _interopRequireDefault(_getFollowing);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

this.id = opts.id;
this.list = [];

this.on('before-mount', function () {
    var self = this;
    (0, _getFollowing2.default)(self.id, function (response) {
        if (response.success) {
            self.list = Object.keys(response.following);
            self.update();
        } else {
            //Handle error
        }
    });
});
});
    
  if (false) {
    module.hot.accept()
    if (module.hot.data) {
      riot.reload('graphjs-profile-following')
    }
  }
  

/***/ }),
/* 62 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


Object.defineProperty(exports, "__esModule", {
	value: true
});

exports.default = function () {
	var args = Array.from(arguments);
	var callback = args.pop();
	getFollowingCall(args, callback);
};

var _api = __webpack_require__(1);

var _api2 = _interopRequireDefault(_api);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function getFollowingCall(args, callback) {
	(0, _api2.default)("getFollowing", {
		"id": args[0]
	}, function (response) {
		callback(response.data);
	});
};

;

/***/ }),
/* 63 */
/***/ (function(module, exports, __webpack_require__) {


    var riot = __webpack_require__(0)
    riot.tag2('graphjs-profile-groups', '<div class="content"> <graphjs-group-card each="{id in list}" id="{id}"></graphjs-group-card> </div>', '', 'class="wallet"', function(opts) {
'use strict';

var _listMemberships = __webpack_require__(112);

var _listMemberships2 = _interopRequireDefault(_listMemberships);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

this.id = opts.id;
this.list = [];

this.on('before-mount', function () {
    var self = this;
    (0, _listMemberships2.default)(self.id, function (response) {
        if (response.success) {
            self.list = [];
            for (var _iterator = response.groups, _isArray = Array.isArray(_iterator), _i = 0, _iterator = _isArray ? _iterator : _iterator[Symbol.iterator]();;) {
                var _ref;

                if (_isArray) {
                    if (_i >= _iterator.length) break;
                    _ref = _iterator[_i++];
                } else {
                    _i = _iterator.next();
                    if (_i.done) break;
                    _ref = _i.value;
                }

                var group = _ref;

                self.list.push(group.id);
            }
            self.update();
        } else {
            //Handle error
        }
    });
});
});
    
  if (false) {
    module.hot.accept()
    if (module.hot.data) {
      riot.reload('graphjs-profile-groups')
    }
  }
  

/***/ }),
/* 64 */
/***/ (function(module, exports, __webpack_require__) {


    var riot = __webpack_require__(0)
    riot.tag2('graphjs-profile-settings', '<div class="warning" if="{failMessages.length > 0 || successMessages.length > 0}"> <ul if="{failMessages.length > 0}" class="fail"> <li each="{failMessage in failMessages}">{failMessage}</li> </ul> <ul if="{successMessages.length > 0}" class="success"> <li each="{successMessage in successMessages}">{successMessage}</li> </ul> </div> <div class="content"> <a ref="uploadWidget" class="avatar"> <img riot-src="{profile ? profile.avatar : \'lib/images/avatars/user.png\'}"> </a> <h2>Profile</h2> <form> <input ref="username" type="text" placeholder="Enter username" riot-value="{profile ? profile.username : \'\'}"> <input ref="email" type="text" placeholder="Enter email address" riot-value="{profile ? profile.email : \'\'}"> <input ref="bio" type="text" placeholder="Enter a short bio" riot-value="{profile ? profile.about : \'\'}"> <input ref="birthday" type="text" placeholder="Enter birthday (MM/DD/YYYY)" riot-value="{profile ? profile.birthday : \'\'}"> <button ref="submit" onclick="{handleProfileSubmit}">Update Profile</button> </form> <h2>Password</h2> <form> <input ref="password" type="password" placeholder="Enter new password"> <input ref="confirmation" type="password" placeholder="Confirm new password"> <button ref="submit" onclick="{handlePasswordSubmit}">Change Password</button> </form> </div>', 'graphjs-profile-settings{display:block;width:100%;text-align:center} graphjs-profile-settings .content .avatar{overflow:hidden;display:inline-block;position:relative;width:10em;height:10em;margin:0 auto;margin-bottom:1.5em;font-family:"Rubik";font-weight:800;text-transform:uppercase;-webkit-border-radius:50%;-moz-border-radius:50%;border-radius:50%;-moz-background-clip:padding;-webkit-background-clip:padding-box;background-clip:padding-box} graphjs-profile-settings .content .avatar:hover::before{padding-top:3.6em;background-color:rgba(0,127,255,0.9)} graphjs-profile-settings .content .avatar::before{content:"Change\\00000aAvatar";display:inline-block;position:absolute;top:0;right:0;bottom:0;left:0;padding-top:6.4em;color:white;line-height:1.4em;vertical-align:middle;background-color:rgba(0,127,255,0.6);white-space:pre;-webkit-transition:all .35s ease;-moz-transition:all .35s ease;-ms-transition:all .35s ease;-o-transition:all .35s ease} graphjs-profile-settings .content .avatar img{width:100%;height:100%} graphjs-profile-settings .content form{max-width:24em;margin:0 auto} graphjs-profile-settings .content form input.success{border:1px solid #00df5f} graphjs-profile-settings .content form input.success::after{content:"OK";display:block;position:absolute;top:0;right:0;width:2.5em;height:2.5em;color:white;font-family:"Rubik";font-weight:800;font-size:1.5em;line-height:2.5em;background-color:#00df5f}', 'class="box"', function(opts) {
'use strict';

var _this = this;

var _getProfile = __webpack_require__(7);

var _getProfile2 = _interopRequireDefault(_getProfile);

var _setProfile = __webpack_require__(65);

var _setProfile2 = _interopRequireDefault(_setProfile);

var _setAvatar = __webpack_require__(66);

var _setAvatar2 = _interopRequireDefault(_setAvatar);

var _setBio = __webpack_require__(67);

var _setBio2 = _interopRequireDefault(_setBio);

var _setBirthday = __webpack_require__(68);

var _setBirthday2 = _interopRequireDefault(_setBirthday);

var _setEmail = __webpack_require__(69);

var _setEmail2 = _interopRequireDefault(_setEmail);

var _setPassword = __webpack_require__(70);

var _setPassword2 = _interopRequireDefault(_setPassword);

var _setUsername = __webpack_require__(71);

var _setUsername2 = _interopRequireDefault(_setUsername);

var _showAlert = __webpack_require__(9);

var _showAlert2 = _interopRequireDefault(_showAlert);

__webpack_require__(113);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

this.failMessages = [];
this.successMessages = [];

this.on('mount', function () {
    var self = this;
    this.handleInformation(opts.id);
    this.refs.uploadWidget.addEventListener("click", function () {
        cloudinary.openUploadWidget({
            cloud_name: 'graphjs',
            upload_preset: 'baafngba',
            multiple: false,
            cropping: 'server',
            cropping_aspect_ratio: 1,
            cropping_coordinates_mode: 'custom',
            theme: 'minimal'
        }, function (error, result) {
            if (result) {
                (0, _setAvatar2.default)(result[0].url, function (response) {
                    if (response.success) {
                        self.profile.avatar = result[0].url;
                        self.update();
                    }
                });
                self.update();
            }
            if (error) {
                //Handle error
            }
        });
    }, false);
});

this.handleInformation = function (id) {
    var self = _this;
    (0, _getProfile2.default)(id, function (response) {
        if (response.success) {
            self.profile = response.profile;
            //let timestamp = new Date(response.profile.birthday * 1000);
            //self.profile.birthday = (timestamp.getMonth() + 1) + '/' + timestamp.getDate() + '/' + timestamp.getFullYear();
            self.update();
        } else {
            //Handle errors
        }
    });
};
this.checkUsernameMinimumLength = function () {
    var usernameMinimumLengthLimit = 1;
    var failMessage = 'Username is too short!';
    if (_this.refs.username.value.length >= usernameMinimumLengthLimit) {
        _this.refs.username.classList.remove('error');
        _this.failMessages.includes(failMessage) && _this.failMessages.splice(_this.failMessages.indexOf(failMessage), 1);
        return true;
    } else {
        _this.refs.username.classList.add('error');
        _this.failMessages.includes(failMessage) || _this.failMessages.push(failMessage);
        return false;
    }
};
this.checkUsernameMaximumLength = function () {
    var usernameMaximumLengthLimit = 12;
    var failMessage = 'Username must be ' + usernameMaximumLengthLimit + ' characters maximum!';
    if (_this.refs.username.value.length <= usernameMaximumLengthLimit) {
        _this.refs.username.classList.remove('error');
        _this.failMessages.includes(failMessage) && _this.failMessages.splice(_this.failMessages.indexOf(failMessage), 1);
        return true;
    } else {
        _this.refs.username.classList.add('error');
        _this.failMessages.includes(failMessage) || _this.failMessages.push(failMessage);
        return false;
    }
};
this.checkUsernamePattern = function () {
    var failMessage = 'Username is invalid. Valid characters are letters, numbers, hyphens, and underscores.';
    var usernamePattern = /^[a-zA-Z0-9-_]+$/;
    if (usernamePattern.test(_this.refs.username.value)) {
        _this.refs.username.classList.remove('error');
        _this.failMessages.includes(failMessage) && _this.failMessages.splice(_this.failMessages.indexOf(failMessage), 1);
        return true;
    } else {
        _this.refs.username.classList.add('error');
        _this.failMessages.includes(failMessage) || _this.failMessages.push(failMessage);
        return false;
    }
};
this.checkEmailPattern = function () {
    var failMessage = 'Email is invalid. Valid format: user@site.com';
    var emailPattern = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;
    if (emailPattern.test(_this.refs.email.value)) {
        _this.refs.email.classList.remove('error');
        _this.failMessages.includes(failMessage) && _this.failMessages.splice(_this.failMessages.indexOf(failMessage), 1);
        return true;
    } else {
        _this.refs.email.classList.add('error');
        _this.failMessages.includes(failMessage) || _this.failMessages.push(failMessage);
        return false;
    }
};
this.checkBioLength = function () {
    var bioLengthLimit = 255;
    var failMessage = 'Bio must be ' + bioLengthLimit + ' characters maximum!';
    if (_this.refs.bio.value.length <= bioLengthLimit) {
        _this.refs.bio.classList.remove('error');
        _this.failMessages.includes(failMessage) && _this.failMessages.splice(_this.failMessages.indexOf(failMessage), 1);
        return true;
    } else {
        _this.refs.bio.classList.add('error');
        _this.failMessages.includes(failMessage) || _this.failMessages.push(failMessage);
        return false;
    }
};
this.checkBirthdayFormat = function () {
    var failMessage = 'Invalid birthday! Correct format: MM/DD/YYYY';
    var birthdayPattern = /^\d{2}\/\d{2}\/\d{4}$/;
    if (birthdayPattern.test(_this.refs.birthday.value)) {
        _this.refs.birthday.classList.remove('error');
        _this.failMessages.includes(failMessage) && _this.failMessages.splice(_this.failMessages.indexOf(failMessage), 1);
        return true;
    } else {
        _this.refs.birthday.classList.add('error');
        _this.failMessages.includes(failMessage) || _this.failMessages.push(failMessage);
        return false;
    }
};
this.checkBirthdayLimit = function () {
    var birthdayLimit = 13;
    var failMessage = 'You must be at least ' + birthdayLimit + ' years old to register!';
    var birthYear = parseInt(_this.refs.birthday.value.split('/')[2]);
    if (new Date().getFullYear() - birthYear >= birthdayLimit) {
        _this.refs.birthday.classList.remove('error');
        _this.failMessages.includes(failMessage) && _this.failMessages.splice(_this.failMessages.indexOf(failMessage), 1);
        return true;
    } else {
        _this.refs.birthday.classList.add('error');
        _this.failMessages.includes(failMessage) || _this.failMessages.push(failMessage);
        return false;
    }
};
this.checkPasswordMinimumLength = function () {
    var passwordMinimumLengthLimit = 5;
    var failMessage = 'Password must be ' + passwordMinimumLengthLimit + ' characters maximum!';
    if (_this.refs.password.value.length >= passwordMinimumLengthLimit) {
        _this.refs.password.classList.remove('error');
        _this.failMessages.includes(failMessage) && _this.failMessages.splice(_this.failMessages.indexOf(failMessage), 1);
        return true;
    } else {
        _this.refs.password.classList.add('error');
        _this.failMessages.includes(failMessage) || _this.failMessages.push(failMessage);
        return false;
    }
};
this.checkPasswordMaximumLength = function () {
    var passwordMaximumLengthLimit = 15;
    var failMessage = 'Password must be ' + passwordMaximumLengthLimit + ' characters maximum!';
    if (_this.refs.password.value.length <= passwordMaximumLengthLimit) {
        _this.refs.password.classList.remove('error');
        _this.failMessages.includes(failMessage) && _this.failMessages.splice(_this.failMessages.indexOf(failMessage), 1);
        return true;
    } else {
        _this.refs.password.classList.add('error');
        _this.failMessages.includes(failMessage) || _this.failMessages.push(failMessage);
        return false;
    }
};
this.checkPasswordMatch = function () {
    var failMessage = 'Passwords do not match.';
    if (_this.refs.password.value == _this.refs.confirmation.value) {
        _this.refs.confirmation.classList.remove('error');
        _this.failMessages.includes(failMessage) && _this.failMessages.splice(_this.failMessages.indexOf(failMessage), 1);
        return true;
    } else {
        _this.refs.confirmation.classList.add('error');
        _this.failMessages.includes(failMessage) || _this.failMessages.push(failMessage);
        return false;
    }
};
this.validateProfile = function () {
    var validUsernameMinimumLength = _this.checkUsernameMinimumLength();
    var validUsernameMaximumLength = _this.checkUsernameMaximumLength();
    var validUsernamePattern = _this.checkUsernamePattern();
    var validEmailPattern = _this.checkEmailPattern();
    var validBioLength = _this.checkBioLength();
    var validBirthdayFormat = _this.checkBirthdayFormat();
    var validBirthdayLimit = _this.checkBirthdayLimit();
    return validUsernameMinimumLength && validUsernameMaximumLength && validUsernamePattern && // Username
    validEmailPattern && // Email
    validBioLength && // Bio
    validBirthdayFormat && validBirthdayLimit // Birthday
    ? true : false;
};
this.validatePassword = function () {
    var validPasswordMinimumLength = _this.checkPasswordMinimumLength();
    var validPasswordMaximumLength = _this.checkPasswordMaximumLength();
    var validPasswordMatch = _this.checkPasswordMatch();
    return validPasswordMinimumLength && validPasswordMaximumLength && validPasswordMatch // Password
    ? true : false;
};
this.handleProfileSubmit = function (event) {
    event.preventDefault();
    var self = _this;
    var username = self.refs.username.value;
    var email = self.refs.email.value;
    var bio = self.refs.bio.value;
    var birthday = self.refs.birthday.value;
    self.refs.bio.className = '';
    self.refs.birthday.className = '';
    self.failMessages = [];
    self.successMessages = [];
    if (self.validateProfile()) {
        if (username != self.profile.username) {
            (0, _setUsername2.default)(username, function (response) {
                var failMessage = 'Username couldn\'t be set.';
                var successMessage = 'Username has been set successfully.';
                if (response.success) {
                    self.profile.username = username;
                    self.refs.username.classList.remove('error');
                    self.refs.username.classList.add('success');
                    self.failMessages.includes(failMessage) && self.failMessages.splice(self.failMessages.indexOf(failMessage), 1);
                    self.successMessages.includes(successMessage) || self.successMessages.push(successMessage);
                    self.update();
                } else {
                    self.refs.username.classList.remove('success');
                    self.refs.username.classList.add('error');
                    self.successMessages.includes(successMessage) && self.successMessages.splice(self.successMessages.indexOf(successMessage), 1);
                    self.failMessages.includes(failMessage) || self.failMessages.push(failMessage);
                    self.update();
                }
            });
        } else {
            var failMessage = 'Username couldn\'t be set.';
            var successMessage = 'Username has been set successfully.';
            self.refs.username.classList.remove('error');
            self.refs.username.classList.add('success');
            self.failMessages.includes(failMessage) && self.failMessages.splice(self.failMessages.indexOf(failMessage), 1);
            self.successMessages.includes(successMessage) || self.successMessages.push(successMessage);
            self.update();
        }
        if (email != self.profile.email) {
            (0, _setEmail2.default)(email, function (response) {
                var failMessage = 'Email couldn\'t be set.';
                var successMessage = 'Email has been set successfully.';
                if (response.success) {
                    self.profile.email = email;
                    self.refs.email.classList.remove('error');
                    self.refs.email.classList.add('success');
                    self.failMessages.includes(failMessage) && self.failMessages.splice(self.failMessages.indexOf(failMessage), 1);
                    self.successMessages.includes(successMessage) || self.successMessages.push(successMessage);
                    self.update();
                } else {
                    self.refs.email.classList.remove('success');
                    self.refs.email.classList.add('error');
                    self.successMessages.includes(successMessage) && self.successMessages.splice(self.successMessages.indexOf(successMessage), 1);
                    self.failMessages.includes(failMessage) || self.failMessages.push(failMessage);
                    self.update();
                }
            });
        } else {
            var _failMessage = 'Email couldn\'t be set.';
            var _successMessage = 'Email has been set successfully.';
            self.refs.email.classList.remove('error');
            self.refs.email.classList.add('success');
            self.failMessages.includes(_failMessage) && self.failMessages.splice(self.failMessages.indexOf(_failMessage), 1);
            self.successMessages.includes(_successMessage) || self.successMessages.push(_successMessage);
            self.update();
        }
        (0, _setBio2.default)(bio, function (response) {
            var failMessage = 'Bio couldn\'t be set.';
            var successMessage = 'Bio has been set successfully.';
            if (response.success) {
                self.profile.about = bio;
                self.refs.bio.classList.remove('error');
                self.refs.bio.classList.add('success');
                self.failMessages.includes(failMessage) && self.failMessages.splice(self.failMessages.indexOf(failMessage), 1);
                self.successMessages.includes(successMessage) || self.successMessages.push(successMessage);
                self.update();
            } else {
                self.refs.bio.classList.remove('success');
                self.refs.bio.classList.add('error');
                self.successMessages.includes(successMessage) && self.successMessages.splice(self.successMessages.indexOf(successMessage), 1);
                self.failMessages.includes(failMessage) || self.failMessages.push(failMessage);
                self.update();
            }
        });
        (0, _setBirthday2.default)(birthday, function (response) {
            var failMessage = 'Birthday couldn\'t be set.';
            var successMessage = 'Birthday has been set successfully.';
            if (response.success) {
                self.profile.birthday = birthday;
                self.refs.birthday.classList.remove('error');
                self.refs.birthday.classList.add('success');
                self.failMessages.includes(failMessage) && self.failMessages.splice(self.failMessages.indexOf(failMessage), 1);
                self.successMessages.includes(successMessage) || self.successMessages.push(successMessage);
                self.update();
            } else {
                self.refs.birthday.classList.remove('success');
                self.refs.birthday.classList.add('error');
                self.successMessages.includes(successMessage) && self.successMessages.splice(self.successMessages.indexOf(successMessage), 1);
                self.failMessages.includes(failMessage) || self.failMessages.push(failMessage);
                self.update();
            }
        });
    }
};
this.handlePasswordSubmit = function (event) {
    event.preventDefault();
    var self = _this;
    var password = self.refs.password.value;
    self.refs.password.className = '';
    self.refs.confirmation.className = '';
    self.failMessages = [];
    self.successMessages = [];
    if (self.validatePassword()) {
        (0, _setPassword2.default)(password, function (response) {
            var failMessage = 'Password couldn\'t be set.';
            var successMessage = 'Password has been set successfully.';
            if (response.success) {
                self.profile.password = password;
                self.refs.password.classList.remove('error');
                self.refs.confirmation.classList.remove('error');
                self.refs.password.classList.add('success');
                self.refs.confirmation.classList.add('success');
                self.failMessages.includes(failMessage) && self.failMessages.splice(self.failMessages.indexOf(failMessage), 1);
                self.successMessages.includes(successMessage) || self.successMessages.push(successMessage);
                self.update();
            } else {
                self.refs.password.classList.remove('success');
                self.refs.confirmation.classList.remove('success');
                self.refs.password.classList.add('error');
                self.refs.confirmation.classList.add('error');
                self.successMessages.includes(successMessage) && self.successMessages.splice(self.successMessages.indexOf(successMessage), 1);
                self.failMessages.includes(failMessage) || self.failMessages.push(failMessage);
                self.update();
            }
        });
    }
};
});
    
  if (false) {
    module.hot.accept()
    if (module.hot.data) {
      riot.reload('graphjs-profile-settings')
    }
  }
  

/***/ }),
/* 65 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


Object.defineProperty(exports, "__esModule", {
	value: true
});

exports.default = function () {
	var args = Array.from(arguments);
	var callback = args.pop();
	setProfileCall(args, callback);
};

var _api = __webpack_require__(1);

var _api2 = _interopRequireDefault(_api);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function setProfileCall(args, callback) {
	(0, _api2.default)("setProfile", {
		"avatar": args[0],
		"birthday": args[1],
		"about": args[2],
		"username": args[3],
		"email": args[4]
	}, function (response) {
		callback(response.data);
	});
};

;

/***/ }),
/* 66 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


Object.defineProperty(exports, "__esModule", {
	value: true
});

exports.default = function () {
	var args = Array.from(arguments);
	var callback = args.pop();
	setAvatarCall(args, callback);
};

var _api = __webpack_require__(1);

var _api2 = _interopRequireDefault(_api);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function setAvatarCall(args, callback) {
	(0, _api2.default)("setProfile", {
		"avatar": args[0]
	}, function (response) {
		callback(response.data);
	});
};

;

/***/ }),
/* 67 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


Object.defineProperty(exports, "__esModule", {
	value: true
});

exports.default = function () {
	var args = Array.from(arguments);
	var callback = args.pop();
	setBioCall(args, callback);
};

var _api = __webpack_require__(1);

var _api2 = _interopRequireDefault(_api);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function setBioCall(args, callback) {
	(0, _api2.default)("setProfile", {
		"about": args[0]
	}, function (response) {
		callback(response.data);
	});
};

;

/***/ }),
/* 68 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


Object.defineProperty(exports, "__esModule", {
	value: true
});

exports.default = function () {
	var args = Array.from(arguments);
	var callback = args.pop();
	setBirthdayCall(args, callback);
};

var _api = __webpack_require__(1);

var _api2 = _interopRequireDefault(_api);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function setBirthdayCall(args, callback) {
	(0, _api2.default)("setProfile", {
		"birthday": args[0]
	}, function (response) {
		callback(response.data);
	});
};

;

/***/ }),
/* 69 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


Object.defineProperty(exports, "__esModule", {
	value: true
});

exports.default = function () {
	var args = Array.from(arguments);
	var callback = args.pop();
	setEmailCall(args, callback);
};

var _api = __webpack_require__(1);

var _api2 = _interopRequireDefault(_api);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function setEmailCall(args, callback) {
	(0, _api2.default)("setProfile", {
		"email": args[0]
	}, function (response) {
		callback(response.data);
	});
};

;

/***/ }),
/* 70 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


Object.defineProperty(exports, "__esModule", {
	value: true
});

exports.default = function () {
	var args = Array.from(arguments);
	var callback = args.pop();
	setPasswordCall(args, callback);
};

var _api = __webpack_require__(1);

var _api2 = _interopRequireDefault(_api);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function setPasswordCall(args, callback) {
	(0, _api2.default)("setProfile", {
		"password": args[0]
	}, function (response) {
		callback(response.data);
	});
};

;

/***/ }),
/* 71 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


Object.defineProperty(exports, "__esModule", {
	value: true
});

exports.default = function () {
	var args = Array.from(arguments);
	var callback = args.pop();
	setUsernameCall(args, callback);
};

var _api = __webpack_require__(1);

var _api2 = _interopRequireDefault(_api);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function setUsernameCall(args, callback) {
	(0, _api2.default)("setProfile", {
		"username": args[0]
	}, function (response) {
		callback(response.data);
	});
};

;

/***/ }),
/* 72 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


Object.defineProperty(exports, "__esModule", {
	value: true
});

exports.default = function (specs) {
	(0, _showOverlay2.default)(tagName, specs);
};

var _showOverlay = __webpack_require__(4);

var _showOverlay2 = _interopRequireDefault(_showOverlay);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

var tagName = 'graphjs-profile';

/***/ }),
/* 73 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


Object.defineProperty(exports, "__esModule", {
	value: true
});

exports.default = function () {
	var args = Array.from(arguments);
	var callback = args.pop();
	followCall(args, callback);
};

var _api = __webpack_require__(1);

var _api2 = _interopRequireDefault(_api);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function followCall(args, callback) {
	(0, _api2.default)("follow", {
		"id": args[0]
	}, function (response) {
		callback(response.data);
	});
};

;

/***/ }),
/* 74 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


Object.defineProperty(exports, "__esModule", {
	value: true
});

exports.default = function (callback) {
	logoutCall(callback);
};

var _api = __webpack_require__(1);

var _api2 = _interopRequireDefault(_api);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function logoutCall(callback) {
	(0, _api2.default)("logout", {}, function (response) {
		callback(response.data);
	});
};

;

/***/ }),
/* 75 */
/***/ (function(module, exports) {

module.exports = "data:font/woff;base64,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"

/***/ }),
/* 76 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


Object.defineProperty(exports, "__esModule", {
	value: true
});
exports.removeStar = exports.getUserStars = exports.getStars = exports.getStar = exports.star = exports.showProfile = exports.showOverlay = exports.showMessages = exports.showGroup = exports.showForumThread = exports.showForumList = exports.showForumCompose = exports.showForum = exports.showComments = exports.showAuthReset = exports.showAuthRegister = exports.showAuthLogin = exports.showAuth = exports.showAlert = exports.setUsername = exports.setProfile = exports.setPassword = exports.setEmail = exports.setBirthday = exports.setBio = exports.setAvatar = exports.getProfile = exports.sendMessage = exports.getOutbox = exports.getMessage = exports.getInbox = exports.getConversations = exports.getConversation = exports.countUnreadMessages = exports.unfollow = exports.getFollowing = exports.getFollowers = exports.getMembers = exports.follow = exports.listMembers = exports.listGroups = exports.joinGroup = exports.createGroup = exports.startThread = exports.replyThread = exports.getThreads = exports.getThread = exports.reset = exports.register = exports.logout = exports.login = exports.getUser = exports.init = undefined;

var _riot = __webpack_require__(0);

var _riot2 = _interopRequireDefault(_riot);

__webpack_require__(77);

__webpack_require__(78);

__webpack_require__(79);

__webpack_require__(80);

__webpack_require__(26);

__webpack_require__(33);

__webpack_require__(35);

__webpack_require__(100);

__webpack_require__(101);

__webpack_require__(102);

__webpack_require__(106);

__webpack_require__(40);

__webpack_require__(43);

__webpack_require__(46);

__webpack_require__(107);

__webpack_require__(108);

__webpack_require__(48);

__webpack_require__(51);

__webpack_require__(52);

__webpack_require__(109);

__webpack_require__(110);

__webpack_require__(111);

__webpack_require__(114);

__webpack_require__(57);

__webpack_require__(58);

__webpack_require__(59);

__webpack_require__(61);

__webpack_require__(63);

__webpack_require__(64);

__webpack_require__(115);

__webpack_require__(116);

__webpack_require__(118);

__webpack_require__(119);

__webpack_require__(120);

__webpack_require__(121);

__webpack_require__(122);

__webpack_require__(123);

__webpack_require__(124);

__webpack_require__(125);

__webpack_require__(126);

__webpack_require__(127);

__webpack_require__(128);

__webpack_require__(129);

__webpack_require__(130);

__webpack_require__(131);

__webpack_require__(132);

__webpack_require__(133);

__webpack_require__(134);

__webpack_require__(135);

__webpack_require__(136);

var _getUser = __webpack_require__(6);

var _getUser2 = _interopRequireDefault(_getUser);

var _login = __webpack_require__(14);

var _login2 = _interopRequireDefault(_login);

var _logout = __webpack_require__(74);

var _logout2 = _interopRequireDefault(_logout);

var _register = __webpack_require__(34);

var _register2 = _interopRequireDefault(_register);

var _reset = __webpack_require__(36);

var _reset2 = _interopRequireDefault(_reset);

var _getThread = __webpack_require__(44);

var _getThread2 = _interopRequireDefault(_getThread);

var _getThreads = __webpack_require__(41);

var _getThreads2 = _interopRequireDefault(_getThreads);

var _replyThread = __webpack_require__(45);

var _replyThread2 = _interopRequireDefault(_replyThread);

var _startThread = __webpack_require__(47);

var _startThread2 = _interopRequireDefault(_startThread);

var _createGroup = __webpack_require__(144);

var _createGroup2 = _interopRequireDefault(_createGroup);

var _joinGroup = __webpack_require__(20);

var _joinGroup2 = _interopRequireDefault(_joinGroup);

var _listGroups = __webpack_require__(145);

var _listGroups2 = _interopRequireDefault(_listGroups);

var _listMembers = __webpack_require__(12);

var _listMembers2 = _interopRequireDefault(_listMembers);

var _follow = __webpack_require__(73);

var _follow2 = _interopRequireDefault(_follow);

var _getFollowers = __webpack_require__(60);

var _getFollowers2 = _interopRequireDefault(_getFollowers);

var _getFollowing = __webpack_require__(62);

var _getFollowing2 = _interopRequireDefault(_getFollowing);

var _getMembers = __webpack_require__(56);

var _getMembers2 = _interopRequireDefault(_getMembers);

var _unfollow = __webpack_require__(146);

var _unfollow2 = _interopRequireDefault(_unfollow);

var _countUnreadMessages = __webpack_require__(147);

var _countUnreadMessages2 = _interopRequireDefault(_countUnreadMessages);

var _getConversation = __webpack_require__(54);

var _getConversation2 = _interopRequireDefault(_getConversation);

var _getConversations = __webpack_require__(53);

var _getConversations2 = _interopRequireDefault(_getConversations);

var _getInbox = __webpack_require__(148);

var _getInbox2 = _interopRequireDefault(_getInbox);

var _getMessage = __webpack_require__(149);

var _getMessage2 = _interopRequireDefault(_getMessage);

var _getOutbox = __webpack_require__(150);

var _getOutbox2 = _interopRequireDefault(_getOutbox);

var _sendMessage = __webpack_require__(55);

var _sendMessage2 = _interopRequireDefault(_sendMessage);

var _getProfile = __webpack_require__(7);

var _getProfile2 = _interopRequireDefault(_getProfile);

var _setAvatar = __webpack_require__(66);

var _setAvatar2 = _interopRequireDefault(_setAvatar);

var _setBio = __webpack_require__(67);

var _setBio2 = _interopRequireDefault(_setBio);

var _setBirthday = __webpack_require__(68);

var _setBirthday2 = _interopRequireDefault(_setBirthday);

var _setEmail = __webpack_require__(69);

var _setEmail2 = _interopRequireDefault(_setEmail);

var _setPassword = __webpack_require__(70);

var _setPassword2 = _interopRequireDefault(_setPassword);

var _setProfile = __webpack_require__(65);

var _setProfile2 = _interopRequireDefault(_setProfile);

var _setUsername = __webpack_require__(71);

var _setUsername2 = _interopRequireDefault(_setUsername);

var _showAlert = __webpack_require__(9);

var _showAlert2 = _interopRequireDefault(_showAlert);

var _showAuth = __webpack_require__(23);

var _showAuth2 = _interopRequireDefault(_showAuth);

var _showLogin = __webpack_require__(10);

var _showLogin2 = _interopRequireDefault(_showLogin);

var _showRegister = __webpack_require__(8);

var _showRegister2 = _interopRequireDefault(_showRegister);

var _showReset = __webpack_require__(13);

var _showReset2 = _interopRequireDefault(_showReset);

var _showComments = __webpack_require__(24);

var _showComments2 = _interopRequireDefault(_showComments);

var _showForum = __webpack_require__(25);

var _showForum2 = _interopRequireDefault(_showForum);

var _showForumCompose = __webpack_require__(42);

var _showForumCompose2 = _interopRequireDefault(_showForumCompose);

var _showForumList = __webpack_require__(19);

var _showForumList2 = _interopRequireDefault(_showForumList);

var _showForumThread = __webpack_require__(18);

var _showForumThread2 = _interopRequireDefault(_showForumThread);

var _showGroup = __webpack_require__(21);

var _showGroup2 = _interopRequireDefault(_showGroup);

var _showMessages = __webpack_require__(11);

var _showMessages2 = _interopRequireDefault(_showMessages);

var _showOverlay = __webpack_require__(4);

var _showOverlay2 = _interopRequireDefault(_showOverlay);

var _showProfile = __webpack_require__(72);

var _showProfile2 = _interopRequireDefault(_showProfile);

var _star = __webpack_require__(37);

var _star2 = _interopRequireDefault(_star);

var _getStar = __webpack_require__(38);

var _getStar2 = _interopRequireDefault(_getStar);

var _getStars = __webpack_require__(16);

var _getStars2 = _interopRequireDefault(_getStars);

var _getUserStars = __webpack_require__(39);

var _getUserStars2 = _interopRequireDefault(_getUserStars);

var _removeStar = __webpack_require__(17);

var _removeStar2 = _interopRequireDefault(_removeStar);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

// Tags
// Riot
_riot2.default.mount('*');

// Init


// Docs
var init = function init(public_id) {
	window.status = public_id;
};

// Styles


// Authentication


// Forum


// Groups


// Members


// Messages


// Profile


// Show


// Star
exports.init = init;
exports.getUser = _getUser2.default;
exports.login = _login2.default;
exports.logout = _logout2.default;
exports.register = _register2.default;
exports.reset = _reset2.default;
exports.getThread = _getThread2.default;
exports.getThreads = _getThreads2.default;
exports.replyThread = _replyThread2.default;
exports.startThread = _startThread2.default;
exports.createGroup = _createGroup2.default;
exports.joinGroup = _joinGroup2.default;
exports.listGroups = _listGroups2.default;
exports.listMembers = _listMembers2.default;
exports.follow = _follow2.default;
exports.getMembers = _getMembers2.default;
exports.getFollowers = _getFollowers2.default;
exports.getFollowing = _getFollowing2.default;
exports.unfollow = _unfollow2.default;
exports.countUnreadMessages = _countUnreadMessages2.default;
exports.getConversation = _getConversation2.default;
exports.getConversations = _getConversations2.default;
exports.getInbox = _getInbox2.default;
exports.getMessage = _getMessage2.default;
exports.getOutbox = _getOutbox2.default;
exports.sendMessage = _sendMessage2.default;
exports.getProfile = _getProfile2.default;
exports.setAvatar = _setAvatar2.default;
exports.setBio = _setBio2.default;
exports.setBirthday = _setBirthday2.default;
exports.setEmail = _setEmail2.default;
exports.setPassword = _setPassword2.default;
exports.setProfile = _setProfile2.default;
exports.setUsername = _setUsername2.default;
exports.showAlert = _showAlert2.default;
exports.showAuth = _showAuth2.default;
exports.showAuthLogin = _showLogin2.default;
exports.showAuthRegister = _showRegister2.default;
exports.showAuthReset = _showReset2.default;
exports.showComments = _showComments2.default;
exports.showForum = _showForum2.default;
exports.showForumCompose = _showForumCompose2.default;
exports.showForumList = _showForumList2.default;
exports.showForumThread = _showForumThread2.default;
exports.showGroup = _showGroup2.default;
exports.showMessages = _showMessages2.default;
exports.showOverlay = _showOverlay2.default;
exports.showProfile = _showProfile2.default;
exports.star = _star2.default;
exports.getStar = _getStar2.default;
exports.getStars = _getStars2.default;
exports.getUserStars = _getUserStars2.default;
exports.removeStar = _removeStar2.default;

/***/ }),
/* 77 */
/***/ (function(module, exports, __webpack_require__) {

(function (global, factory) {
	 true ? factory(exports, __webpack_require__(0)) :
	typeof define === 'function' && define.amd ? define(['exports', 'riot'], factory) :
	(factory((global.riotHotReload = global.riotHotReload || {}),global.riot));
}(this, (function (exports,riot) { 'use strict';

var nonState = 'isMounted opts'.split(' ');

function reload(name) {
  riot.util.styleManager.inject();

  var elems = document.querySelectorAll((name + ", [data-is=" + name + "]"));
  var tags = [];

  for (var i = 0; i < elems.length; i++) {
    var el = elems[i], oldTag = el._tag, v;
    reload.trigger('before-unmount', oldTag);
    oldTag.unmount(true); // detach the old tag

    // reset the innerHTML and attributes to how they were before mount
    el.innerHTML = oldTag.__.innerHTML;
    (oldTag.__.instAttrs || []).map(function(attr) {
      el.setAttribute(attr.name, attr.value);
    });

    // copy options for creating the new tag
    var newOpts = {};
    for(key in oldTag.opts) {
      newOpts[key] = oldTag.opts[key];
    }
    newOpts.parent = oldTag.parent;

    // create the new tag
    reload.trigger('before-mount', newOpts, oldTag);
    var newTag = riot.mount(el, newOpts)[0];

    // copy state from the old to new tag
    for(var key in oldTag) {
      v = oldTag[key];
      if (~nonState.indexOf(key)) { continue }
      newTag[key] = v;
    }
    newTag.update();
    tags.push(newTag);
    reload.trigger('after-mount', newTag, oldTag);
  }

  return tags
}

riot.observable(reload);
riot.reload = reload;
if (riot.default) { riot.default.reload = reload; }

exports.reload = reload;
exports['default'] = reload;

Object.defineProperty(exports, '__esModule', { value: true });

})));


/***/ }),
/* 78 */
/***/ (function(module, exports, __webpack_require__) {


    var riot = __webpack_require__(0)
    riot.tag2('graphjs-overlay', '<div ref="container"></div>', 'graphjs-overlay{display:table;position:fixed;top:0;right:0;left:0;bottom:0;width:100vw;height:100vh;color:rgba(63,95,127,0.65);background-color:rgba(0,0,0,0.85)} graphjs-overlay.scroll{display:block;overflow-y:scroll} graphjs-overlay.scroll>div{display:block} graphjs-overlay>div{display:table-cell;width:100%;height:auto;min-height:100%;padding:5%;text-align:center;vertical-align:middle} graphjs-overlay>div>*{margin-left:auto;margin-right:auto;text-align:left}', 'class="{opts.scroll ? \'scroll\' : \'\'}" onclick="{handleExit}" if="{overlayActive}"', function(opts) {
'use strict';

var _this = this;

// Create tag
var tag = document.createElement(opts.component);
delete opts.component;
// Set tag properties
for (var _iterator = Object.keys(opts), _isArray = Array.isArray(_iterator), _i = 0, _iterator = _isArray ? _iterator : _iterator[Symbol.iterator]();;) {
    var _ref;

    if (_isArray) {
        if (_i >= _iterator.length) break;
        _ref = _iterator[_i++];
    } else {
        _i = _iterator.next();
        if (_i.done) break;
        _ref = _i.value;
    }

    var key = _ref;

    var attribute = document.createAttribute(key);
    attribute.value = opts[key];
    tag.setAttributeNode(attribute);
}
tag.onclick = function (event) {
    event.stopPropagation();
};
this.overlayActive = true;
this.handleExit = function (event) {
    _this.unmount();
};
// Mount & append tag on mount
this.on('mount', function () {
    riot.mount(tag);
    this.refs.container.appendChild(tag);
    document.body.style.overflow = 'hidden';
});
this.on('unmount', function () {
    document.body.style.overflow = 'auto';
});
});
    
  if (false) {
    module.hot.accept()
    if (module.hot.data) {
      riot.reload('graphjs-overlay')
    }
  }
  

/***/ }),
/* 79 */
/***/ (function(module, exports, __webpack_require__) {


    var riot = __webpack_require__(0)
    riot.tag2('graphjs-alert', '<div class="header" if="{opts.title}"> <div class="title">{opts.title}</div> </div> <div class="content"> <p>{opts.message}</p> </div> <button if="{opts.customoption == undefined || opts.customoption == \'\'}" onclick="{handleButton}">Done</button> <button ref="custom" if="{opts.customoption}" onclick="{handleButton}">{opts.customoption}</button> <button if="{opts.customoption && opts.negativeoption}" onclick="{handleButton}" class="danger">{opts.negativeoption}</button>', 'graphjs-alert{display:block;width:320px;color:rgba(63,95,127,0.65)} graphjs-alert .content p{text-align:center;font-size:1.1em} graphjs-alert>button{color:#007fff !important;font-family:"Rubik";font-weight:700;border-top-left-radius:0;border-top-right-radius:0;background-color:white !important;-webkit-box-shadow:inset 0 2px 1px rgba(0,0,0,0.1);-moz-box-shadow:inset 0 2px 1px rgba(0,0,0,0.1);box-shadow:inset 0 2px 1px rgba(0,0,0,0.1)} graphjs-alert>button:hover{color:#198cff !important} graphjs-alert>button:active{color:#0072e6 !important} graphjs-alert>button:hover{background-color:white !important} graphjs-alert>button.danger{color:#ff4f4f !important;background-color:white} graphjs-alert>button.danger:hover{color:#ff6161 !important} graphjs-alert>button.danger:active{color:#e64747 !important} graphjs-alert>button.full{width:100%} graphjs-alert>button.half{float:left;width:50%} graphjs-alert>button.half:first-of-type{border-bottom-right-radius:0} graphjs-alert>button.half:last-of-type{border-bottom-left-radius:0}', 'class="box"', function(opts) {
'use strict';

var _this = this;

var _hideOverlay = __webpack_require__(22);

var _hideOverlay2 = _interopRequireDefault(_hideOverlay);

var _showAuth = __webpack_require__(23);

var _showAuth2 = _interopRequireDefault(_showAuth);

var _showLogin = __webpack_require__(10);

var _showLogin2 = _interopRequireDefault(_showLogin);

var _showRegister = __webpack_require__(8);

var _showRegister2 = _interopRequireDefault(_showRegister);

var _showReset = __webpack_require__(13);

var _showReset2 = _interopRequireDefault(_showReset);

var _showComments = __webpack_require__(24);

var _showComments2 = _interopRequireDefault(_showComments);

var _showForum = __webpack_require__(25);

var _showForum2 = _interopRequireDefault(_showForum);

var _showMessages = __webpack_require__(11);

var _showMessages2 = _interopRequireDefault(_showMessages);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

this.showFunctions = {
    auth: _showAuth2.default,
    login: _showLogin2.default,
    register: _showRegister2.default,
    reset: _showReset2.default,
    comments: _showComments2.default,
    forum: _showForum2.default,
    message: _showMessages2.default
};
this.handleButton = function (event) {
    if (event.target.hasAttribute('to')) {
        //Needs improvement
        window.location.href = window.location.href + opts.to;
    } else if (event.target.hasAttribute('show')) {
        _this.showFunctions.hasOwnProperty(opts.show) ? _this.showFunctions[opts.show]() : (0, _hideOverlay2.default)();
    } else {
        (0, _hideOverlay2.default)();
    }
};
this.on('mount', function () {
    var buttonList = this.root.getElementsByTagName('button');
    var buttonClass = buttonList.length > 1 ? 'half' : 'full';
    for (var i = 0; i < buttonList.length; i++) {
        buttonList[i].classList.add(buttonClass);
    }
    opts.show && this.refs.custom.setAttribute('show', opts.show);
    opts.to && this.refs.custom.setAttribute('to', opts.to);
});
});

    
  if (false) {
    module.hot.accept()
    if (module.hot.data) {
      riot.reload('graphjs-alert')
    }
  }
  

/***/ }),
/* 80 */
/***/ (function(module, exports, __webpack_require__) {


    var riot = __webpack_require__(0)
    riot.tag2('graphjs-auth', '<graphjs-auth-login minor="{true}" title="{opts.title}" callback="{changeProperties}" if="{this.active == \'login\'}"></graphjs-auth-login> <graphjs-auth-register minor="{true}" title="{opts.title}" callback="{changeProperties}" if="{this.active == \'register\'}"></graphjs-auth-register> <graphjs-auth-reset minor="{true}" title="{opts.title}" callback="{changeProperties}" if="{this.active == \'reset\'}"></graphjs-auth-reset>', 'graphjs-auth{display:block;width:320px;color:rgba(63,95,127,0.65)}', 'class="box"', function(opts) {
'use strict';

var _this = this;

__webpack_require__(26);

__webpack_require__(33);

__webpack_require__(35);

this.active = opts.default || 'login';
this.changeProperties = function (event) {
    _this.active = event.currentTarget.dataset.link;
    _this.update();
};
});
    
  if (false) {
    module.hot.accept()
    if (module.hot.data) {
      riot.reload('graphjs-auth')
    }
  }
  

/***/ }),
/* 81 */
/***/ (function(module, exports, __webpack_require__) {

module.exports = __webpack_require__(82);

/***/ }),
/* 82 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


var utils = __webpack_require__(5);
var bind = __webpack_require__(27);
var Axios = __webpack_require__(84);
var defaults = __webpack_require__(15);

/**
 * Create an instance of Axios
 *
 * @param {Object} defaultConfig The default config for the instance
 * @return {Axios} A new instance of Axios
 */
function createInstance(defaultConfig) {
  var context = new Axios(defaultConfig);
  var instance = bind(Axios.prototype.request, context);

  // Copy axios.prototype to instance
  utils.extend(instance, Axios.prototype, context);

  // Copy context to instance
  utils.extend(instance, context);

  return instance;
}

// Create the default instance to be exported
var axios = createInstance(defaults);

// Expose Axios class to allow class inheritance
axios.Axios = Axios;

// Factory for creating new instances
axios.create = function create(instanceConfig) {
  return createInstance(utils.merge(defaults, instanceConfig));
};

// Expose Cancel & CancelToken
axios.Cancel = __webpack_require__(32);
axios.CancelToken = __webpack_require__(98);
axios.isCancel = __webpack_require__(31);

// Expose all/spread
axios.all = function all(promises) {
  return Promise.all(promises);
};
axios.spread = __webpack_require__(99);

module.exports = axios;

// Allow use of default import syntax in TypeScript
module.exports.default = axios;


/***/ }),
/* 83 */
/***/ (function(module, exports) {

/*!
 * Determine if an object is a Buffer
 *
 * @author   Feross Aboukhadijeh <https://feross.org>
 * @license  MIT
 */

// The _isBuffer check is for Safari 5-7 support, because it's missing
// Object.prototype.constructor. Remove this eventually
module.exports = function (obj) {
  return obj != null && (isBuffer(obj) || isSlowBuffer(obj) || !!obj._isBuffer)
}

function isBuffer (obj) {
  return !!obj.constructor && typeof obj.constructor.isBuffer === 'function' && obj.constructor.isBuffer(obj)
}

// For Node v0.10 support. Remove this eventually.
function isSlowBuffer (obj) {
  return typeof obj.readFloatLE === 'function' && typeof obj.slice === 'function' && isBuffer(obj.slice(0, 0))
}


/***/ }),
/* 84 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


var defaults = __webpack_require__(15);
var utils = __webpack_require__(5);
var InterceptorManager = __webpack_require__(93);
var dispatchRequest = __webpack_require__(94);

/**
 * Create a new instance of Axios
 *
 * @param {Object} instanceConfig The default config for the instance
 */
function Axios(instanceConfig) {
  this.defaults = instanceConfig;
  this.interceptors = {
    request: new InterceptorManager(),
    response: new InterceptorManager()
  };
}

/**
 * Dispatch a request
 *
 * @param {Object} config The config specific for this request (merged with this.defaults)
 */
Axios.prototype.request = function request(config) {
  /*eslint no-param-reassign:0*/
  // Allow for axios('example/url'[, config]) a la fetch API
  if (typeof config === 'string') {
    config = utils.merge({
      url: arguments[0]
    }, arguments[1]);
  }

  config = utils.merge(defaults, this.defaults, { method: 'get' }, config);
  config.method = config.method.toLowerCase();

  // Hook up interceptors middleware
  var chain = [dispatchRequest, undefined];
  var promise = Promise.resolve(config);

  this.interceptors.request.forEach(function unshiftRequestInterceptors(interceptor) {
    chain.unshift(interceptor.fulfilled, interceptor.rejected);
  });

  this.interceptors.response.forEach(function pushResponseInterceptors(interceptor) {
    chain.push(interceptor.fulfilled, interceptor.rejected);
  });

  while (chain.length) {
    promise = promise.then(chain.shift(), chain.shift());
  }

  return promise;
};

// Provide aliases for supported request methods
utils.forEach(['delete', 'get', 'head', 'options'], function forEachMethodNoData(method) {
  /*eslint func-names:0*/
  Axios.prototype[method] = function(url, config) {
    return this.request(utils.merge(config || {}, {
      method: method,
      url: url
    }));
  };
});

utils.forEach(['post', 'put', 'patch'], function forEachMethodWithData(method) {
  /*eslint func-names:0*/
  Axios.prototype[method] = function(url, data, config) {
    return this.request(utils.merge(config || {}, {
      method: method,
      url: url,
      data: data
    }));
  };
});

module.exports = Axios;


/***/ }),
/* 85 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


var utils = __webpack_require__(5);

module.exports = function normalizeHeaderName(headers, normalizedName) {
  utils.forEach(headers, function processHeader(value, name) {
    if (name !== normalizedName && name.toUpperCase() === normalizedName.toUpperCase()) {
      headers[normalizedName] = value;
      delete headers[name];
    }
  });
};


/***/ }),
/* 86 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


var createError = __webpack_require__(30);

/**
 * Resolve or reject a Promise based on response status.
 *
 * @param {Function} resolve A function that resolves the promise.
 * @param {Function} reject A function that rejects the promise.
 * @param {object} response The response.
 */
module.exports = function settle(resolve, reject, response) {
  var validateStatus = response.config.validateStatus;
  // Note: status is not exposed by XDomainRequest
  if (!response.status || !validateStatus || validateStatus(response.status)) {
    resolve(response);
  } else {
    reject(createError(
      'Request failed with status code ' + response.status,
      response.config,
      null,
      response.request,
      response
    ));
  }
};


/***/ }),
/* 87 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


/**
 * Update an Error with the specified config, error code, and response.
 *
 * @param {Error} error The error to update.
 * @param {Object} config The config.
 * @param {string} [code] The error code (for example, 'ECONNABORTED').
 * @param {Object} [request] The request.
 * @param {Object} [response] The response.
 * @returns {Error} The error.
 */
module.exports = function enhanceError(error, config, code, request, response) {
  error.config = config;
  if (code) {
    error.code = code;
  }
  error.request = request;
  error.response = response;
  return error;
};


/***/ }),
/* 88 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


var utils = __webpack_require__(5);

function encode(val) {
  return encodeURIComponent(val).
    replace(/%40/gi, '@').
    replace(/%3A/gi, ':').
    replace(/%24/g, '$').
    replace(/%2C/gi, ',').
    replace(/%20/g, '+').
    replace(/%5B/gi, '[').
    replace(/%5D/gi, ']');
}

/**
 * Build a URL by appending params to the end
 *
 * @param {string} url The base of the url (e.g., http://www.google.com)
 * @param {object} [params] The params to be appended
 * @returns {string} The formatted url
 */
module.exports = function buildURL(url, params, paramsSerializer) {
  /*eslint no-param-reassign:0*/
  if (!params) {
    return url;
  }

  var serializedParams;
  if (paramsSerializer) {
    serializedParams = paramsSerializer(params);
  } else if (utils.isURLSearchParams(params)) {
    serializedParams = params.toString();
  } else {
    var parts = [];

    utils.forEach(params, function serialize(val, key) {
      if (val === null || typeof val === 'undefined') {
        return;
      }

      if (utils.isArray(val)) {
        key = key + '[]';
      }

      if (!utils.isArray(val)) {
        val = [val];
      }

      utils.forEach(val, function parseValue(v) {
        if (utils.isDate(v)) {
          v = v.toISOString();
        } else if (utils.isObject(v)) {
          v = JSON.stringify(v);
        }
        parts.push(encode(key) + '=' + encode(v));
      });
    });

    serializedParams = parts.join('&');
  }

  if (serializedParams) {
    url += (url.indexOf('?') === -1 ? '?' : '&') + serializedParams;
  }

  return url;
};


/***/ }),
/* 89 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


var utils = __webpack_require__(5);

// Headers whose duplicates are ignored by node
// c.f. https://nodejs.org/api/http.html#http_message_headers
var ignoreDuplicateOf = [
  'age', 'authorization', 'content-length', 'content-type', 'etag',
  'expires', 'from', 'host', 'if-modified-since', 'if-unmodified-since',
  'last-modified', 'location', 'max-forwards', 'proxy-authorization',
  'referer', 'retry-after', 'user-agent'
];

/**
 * Parse headers into an object
 *
 * ```
 * Date: Wed, 27 Aug 2014 08:58:49 GMT
 * Content-Type: application/json
 * Connection: keep-alive
 * Transfer-Encoding: chunked
 * ```
 *
 * @param {String} headers Headers needing to be parsed
 * @returns {Object} Headers parsed into an object
 */
module.exports = function parseHeaders(headers) {
  var parsed = {};
  var key;
  var val;
  var i;

  if (!headers) { return parsed; }

  utils.forEach(headers.split('\n'), function parser(line) {
    i = line.indexOf(':');
    key = utils.trim(line.substr(0, i)).toLowerCase();
    val = utils.trim(line.substr(i + 1));

    if (key) {
      if (parsed[key] && ignoreDuplicateOf.indexOf(key) >= 0) {
        return;
      }
      if (key === 'set-cookie') {
        parsed[key] = (parsed[key] ? parsed[key] : []).concat([val]);
      } else {
        parsed[key] = parsed[key] ? parsed[key] + ', ' + val : val;
      }
    }
  });

  return parsed;
};


/***/ }),
/* 90 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


var utils = __webpack_require__(5);

module.exports = (
  utils.isStandardBrowserEnv() ?

  // Standard browser envs have full support of the APIs needed to test
  // whether the request URL is of the same origin as current location.
  (function standardBrowserEnv() {
    var msie = /(msie|trident)/i.test(navigator.userAgent);
    var urlParsingNode = document.createElement('a');
    var originURL;

    /**
    * Parse a URL to discover it's components
    *
    * @param {String} url The URL to be parsed
    * @returns {Object}
    */
    function resolveURL(url) {
      var href = url;

      if (msie) {
        // IE needs attribute set twice to normalize properties
        urlParsingNode.setAttribute('href', href);
        href = urlParsingNode.href;
      }

      urlParsingNode.setAttribute('href', href);

      // urlParsingNode provides the UrlUtils interface - http://url.spec.whatwg.org/#urlutils
      return {
        href: urlParsingNode.href,
        protocol: urlParsingNode.protocol ? urlParsingNode.protocol.replace(/:$/, '') : '',
        host: urlParsingNode.host,
        search: urlParsingNode.search ? urlParsingNode.search.replace(/^\?/, '') : '',
        hash: urlParsingNode.hash ? urlParsingNode.hash.replace(/^#/, '') : '',
        hostname: urlParsingNode.hostname,
        port: urlParsingNode.port,
        pathname: (urlParsingNode.pathname.charAt(0) === '/') ?
                  urlParsingNode.pathname :
                  '/' + urlParsingNode.pathname
      };
    }

    originURL = resolveURL(window.location.href);

    /**
    * Determine if a URL shares the same origin as the current location
    *
    * @param {String} requestURL The URL to test
    * @returns {boolean} True if URL shares the same origin, otherwise false
    */
    return function isURLSameOrigin(requestURL) {
      var parsed = (utils.isString(requestURL)) ? resolveURL(requestURL) : requestURL;
      return (parsed.protocol === originURL.protocol &&
            parsed.host === originURL.host);
    };
  })() :

  // Non standard browser envs (web workers, react-native) lack needed support.
  (function nonStandardBrowserEnv() {
    return function isURLSameOrigin() {
      return true;
    };
  })()
);


/***/ }),
/* 91 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


// btoa polyfill for IE<10 courtesy https://github.com/davidchambers/Base64.js

var chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=';

function E() {
  this.message = 'String contains an invalid character';
}
E.prototype = new Error;
E.prototype.code = 5;
E.prototype.name = 'InvalidCharacterError';

function btoa(input) {
  var str = String(input);
  var output = '';
  for (
    // initialize result and counter
    var block, charCode, idx = 0, map = chars;
    // if the next str index does not exist:
    //   change the mapping table to "="
    //   check if d has no fractional digits
    str.charAt(idx | 0) || (map = '=', idx % 1);
    // "8 - idx % 1 * 8" generates the sequence 2, 4, 6, 8
    output += map.charAt(63 & block >> 8 - idx % 1 * 8)
  ) {
    charCode = str.charCodeAt(idx += 3 / 4);
    if (charCode > 0xFF) {
      throw new E();
    }
    block = block << 8 | charCode;
  }
  return output;
}

module.exports = btoa;


/***/ }),
/* 92 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


var utils = __webpack_require__(5);

module.exports = (
  utils.isStandardBrowserEnv() ?

  // Standard browser envs support document.cookie
  (function standardBrowserEnv() {
    return {
      write: function write(name, value, expires, path, domain, secure) {
        var cookie = [];
        cookie.push(name + '=' + encodeURIComponent(value));

        if (utils.isNumber(expires)) {
          cookie.push('expires=' + new Date(expires).toGMTString());
        }

        if (utils.isString(path)) {
          cookie.push('path=' + path);
        }

        if (utils.isString(domain)) {
          cookie.push('domain=' + domain);
        }

        if (secure === true) {
          cookie.push('secure');
        }

        document.cookie = cookie.join('; ');
      },

      read: function read(name) {
        var match = document.cookie.match(new RegExp('(^|;\\s*)(' + name + ')=([^;]*)'));
        return (match ? decodeURIComponent(match[3]) : null);
      },

      remove: function remove(name) {
        this.write(name, '', Date.now() - 86400000);
      }
    };
  })() :

  // Non standard browser env (web workers, react-native) lack needed support.
  (function nonStandardBrowserEnv() {
    return {
      write: function write() {},
      read: function read() { return null; },
      remove: function remove() {}
    };
  })()
);


/***/ }),
/* 93 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


var utils = __webpack_require__(5);

function InterceptorManager() {
  this.handlers = [];
}

/**
 * Add a new interceptor to the stack
 *
 * @param {Function} fulfilled The function to handle `then` for a `Promise`
 * @param {Function} rejected The function to handle `reject` for a `Promise`
 *
 * @return {Number} An ID used to remove interceptor later
 */
InterceptorManager.prototype.use = function use(fulfilled, rejected) {
  this.handlers.push({
    fulfilled: fulfilled,
    rejected: rejected
  });
  return this.handlers.length - 1;
};

/**
 * Remove an interceptor from the stack
 *
 * @param {Number} id The ID that was returned by `use`
 */
InterceptorManager.prototype.eject = function eject(id) {
  if (this.handlers[id]) {
    this.handlers[id] = null;
  }
};

/**
 * Iterate over all the registered interceptors
 *
 * This method is particularly useful for skipping over any
 * interceptors that may have become `null` calling `eject`.
 *
 * @param {Function} fn The function to call for each interceptor
 */
InterceptorManager.prototype.forEach = function forEach(fn) {
  utils.forEach(this.handlers, function forEachHandler(h) {
    if (h !== null) {
      fn(h);
    }
  });
};

module.exports = InterceptorManager;


/***/ }),
/* 94 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


var utils = __webpack_require__(5);
var transformData = __webpack_require__(95);
var isCancel = __webpack_require__(31);
var defaults = __webpack_require__(15);
var isAbsoluteURL = __webpack_require__(96);
var combineURLs = __webpack_require__(97);

/**
 * Throws a `Cancel` if cancellation has been requested.
 */
function throwIfCancellationRequested(config) {
  if (config.cancelToken) {
    config.cancelToken.throwIfRequested();
  }
}

/**
 * Dispatch a request to the server using the configured adapter.
 *
 * @param {object} config The config that is to be used for the request
 * @returns {Promise} The Promise to be fulfilled
 */
module.exports = function dispatchRequest(config) {
  throwIfCancellationRequested(config);

  // Support baseURL config
  if (config.baseURL && !isAbsoluteURL(config.url)) {
    config.url = combineURLs(config.baseURL, config.url);
  }

  // Ensure headers exist
  config.headers = config.headers || {};

  // Transform request data
  config.data = transformData(
    config.data,
    config.headers,
    config.transformRequest
  );

  // Flatten headers
  config.headers = utils.merge(
    config.headers.common || {},
    config.headers[config.method] || {},
    config.headers || {}
  );

  utils.forEach(
    ['delete', 'get', 'head', 'post', 'put', 'patch', 'common'],
    function cleanHeaderConfig(method) {
      delete config.headers[method];
    }
  );

  var adapter = config.adapter || defaults.adapter;

  return adapter(config).then(function onAdapterResolution(response) {
    throwIfCancellationRequested(config);

    // Transform response data
    response.data = transformData(
      response.data,
      response.headers,
      config.transformResponse
    );

    return response;
  }, function onAdapterRejection(reason) {
    if (!isCancel(reason)) {
      throwIfCancellationRequested(config);

      // Transform response data
      if (reason && reason.response) {
        reason.response.data = transformData(
          reason.response.data,
          reason.response.headers,
          config.transformResponse
        );
      }
    }

    return Promise.reject(reason);
  });
};


/***/ }),
/* 95 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


var utils = __webpack_require__(5);

/**
 * Transform the data for a request or a response
 *
 * @param {Object|String} data The data to be transformed
 * @param {Array} headers The headers for the request or response
 * @param {Array|Function} fns A single function or Array of functions
 * @returns {*} The resulting transformed data
 */
module.exports = function transformData(data, headers, fns) {
  /*eslint no-param-reassign:0*/
  utils.forEach(fns, function transform(fn) {
    data = fn(data, headers);
  });

  return data;
};


/***/ }),
/* 96 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


/**
 * Determines whether the specified URL is absolute
 *
 * @param {string} url The URL to test
 * @returns {boolean} True if the specified URL is absolute, otherwise false
 */
module.exports = function isAbsoluteURL(url) {
  // A URL is considered absolute if it begins with "<scheme>://" or "//" (protocol-relative URL).
  // RFC 3986 defines scheme name as a sequence of characters beginning with a letter and followed
  // by any combination of letters, digits, plus, period, or hyphen.
  return /^([a-z][a-z\d\+\-\.]*:)?\/\//i.test(url);
};


/***/ }),
/* 97 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


/**
 * Creates a new URL by combining the specified URLs
 *
 * @param {string} baseURL The base URL
 * @param {string} relativeURL The relative URL
 * @returns {string} The combined URL
 */
module.exports = function combineURLs(baseURL, relativeURL) {
  return relativeURL
    ? baseURL.replace(/\/+$/, '') + '/' + relativeURL.replace(/^\/+/, '')
    : baseURL;
};


/***/ }),
/* 98 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


var Cancel = __webpack_require__(32);

/**
 * A `CancelToken` is an object that can be used to request cancellation of an operation.
 *
 * @class
 * @param {Function} executor The executor function.
 */
function CancelToken(executor) {
  if (typeof executor !== 'function') {
    throw new TypeError('executor must be a function.');
  }

  var resolvePromise;
  this.promise = new Promise(function promiseExecutor(resolve) {
    resolvePromise = resolve;
  });

  var token = this;
  executor(function cancel(message) {
    if (token.reason) {
      // Cancellation has already been requested
      return;
    }

    token.reason = new Cancel(message);
    resolvePromise(token.reason);
  });
}

/**
 * Throws a `Cancel` if cancellation has been requested.
 */
CancelToken.prototype.throwIfRequested = function throwIfRequested() {
  if (this.reason) {
    throw this.reason;
  }
};

/**
 * Returns an object that contains a new `CancelToken` and a function that, when called,
 * cancels the `CancelToken`.
 */
CancelToken.source = function source() {
  var cancel;
  var token = new CancelToken(function executor(c) {
    cancel = c;
  });
  return {
    token: token,
    cancel: cancel
  };
};

module.exports = CancelToken;


/***/ }),
/* 99 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


/**
 * Syntactic sugar for invoking a function and expanding an array for arguments.
 *
 * Common use case would be to use `Function.prototype.apply`.
 *
 *  ```js
 *  function f(x, y, z) {}
 *  var args = [1, 2, 3];
 *  f.apply(null, args);
 *  ```
 *
 * With `spread` this example can be re-written.
 *
 *  ```js
 *  spread(function(x, y, z) {})([1, 2, 3]);
 *  ```
 *
 * @param {Function} callback
 * @returns {Function}
 */
module.exports = function spread(callback) {
  return function wrap(arr) {
    return callback.apply(null, arr);
  };
};


/***/ }),
/* 100 */
/***/ (function(module, exports, __webpack_require__) {


    var riot = __webpack_require__(0)
    riot.tag2('graphjs-star-button', '<a class="{active ? \'active\' : \'\'}" onclick="{handleStar}"> <div class="{type + \' icon\'}"> <svg if="{type == \'default\'}" viewbox="0 0 62 58" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"> <path transform="translate(-19.000000, 0.000000)" d="M78.55,20.92 L60,18.22 L51.41,0.88 C51.1430837,0.342731823 50.5949178,0.00297581751 49.995,0.00297581751 C49.3950822,0.00297581751 48.8469163,0.342731823 48.58,0.88 L40,18.22 L21.43,20.92 C20.7357885,21.0320591 20.1641226,21.5260416 19.9525703,22.1966625 C19.7410179,22.8672834 19.9257511,23.5998777 20.43,24.09 L33.86,37.2 L30.64,56 C30.5260197,56.6400466 30.78705,57.289052 31.3124543,57.6719377 C31.8378586,58.0548234 32.535622,58.1045341 33.11,57.8 L50,48.92 L66.89,57.8 C67.464378,58.1045341 68.1621414,58.0548234 68.6875457,57.6719377 C69.21295,57.289052 69.4739803,56.6400466 69.36,56 L66.14,37.2 L79.58,24.1 C80.0914811,23.6064567 80.2769729,22.8645697 80.0579562,22.1883821 C79.8389395,21.5121946 79.2537111,21.0199434 78.55,20.92 Z"></path> </svg> <svg if="{type == \'like\'}" viewbox="0 0 42 54" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"> <path transform="translate(-21.000000, 0.000000)" d="M62.973,24.929 C62.727,26.613 61.768,28.044 60.453,28.9 C60.152,29.099 59.844,29.372 59.515,29.619 L59.385,29.626 C60.631,31.886 60.487,33.536 59.042,35.693 C58.816,36.035 58.645,36.295 58.419,36.528 C59.74,39.253 58.994,42.499 56.666,44.327 C56.755,45.422 56.885,46.504 56.755,47.586 C56.399,50.729 54.099,52.92 50.778,53.31 C50.21,53.372 49.621,53.426 49.032,53.454 C48.635,53.475 48.224,53.488 47.813,53.495 C44.616,53.187 41.418,52.728 38.228,52.345 C35.25,51.996 32.285,51.489 29.088,50.955 C27.814,50.736 26.507,50.517 25.137,50.305 L25.137,50.305 C23.2995486,50.305 21.81,48.8154514 21.81,46.978 L21.81,30.584 C21.81,30.057 21.817,29.53 21.831,29.002 C21.831,28.858 21.838,28.714 21.838,28.571 C21.859,27.955 21.893,27.332 21.934,26.709 C22.064,24.648 25.275,24.429 26.597,23.827 C27.165,23.567 27.645,23.245 28.069,22.875 C28.24,22.731 28.404,22.574 28.562,22.416 C29.452,21.567 30.281,20.608 31.13,19.623 C31.349,19.377 31.561,19.123 31.774,18.884 C33.287,17.152 34.629,15.666 35.889,14.338 C36.587,13.599 37.183,12.791 37.683,11.901 C38.566,10.333 39.162,8.505 39.504,6.321 C39.689,5.123 39.853,3.808 39.997,2.322 C40.072,1.541 40.469,0.59 41.914,0.514 C43.229,0.452 44.495,0.822 45.591,1.507 C47.357,2.616 48.658,4.54 48.919,6.772 C49.124,8.497 48.905,10.23 48.221,12.386 C47.612,14.296 47.043,16.261 46.482,18.165 L46.044,19.671 L46.27,19.664 C48.146,19.568 50.022,19.472 51.898,19.37 C53.733,19.274 55.575,19.178 57.416,19.082 C57.614,19.075 57.813,19.062 58.012,19.048 C58.594,19.117 59.114,19.233 59.594,19.39 C59.772,19.445 59.93,19.513 60.08,19.582 C60.176,19.616 60.251,19.657 60.34,19.698 C60.402,19.732 60.463,19.78 60.518,19.814 C60.586,19.855 60.662,19.896 60.723,19.944 C60.798,20.006 60.874,20.054 60.935,20.108 C62.378,21.19 63.233,23.101 62.973,24.929 Z"></path> </svg> <svg if="{type == \'love\'}" viewbox="0 0 81 71" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"> <path transform="translate(-10.000000, 0.000000)" d="M67.5,1 C61.5,1 56.7,3.2 52.4,7.4 C52.4,7.4 52.4,7.4 52.4,7.4 L50,10.4 L47.6,7.5 C47.6,7.5 47.6,7.5 47.6,7.5 C47.6,7.5 47.6,7.5 47.6,7.5 C43.4,3.3 38.5,0.9 32.5,0.9 C26.5,0.9 20.8,3.2 16.6,7.5 C12.4,11.7 10,17.4 10,23.4 C10,29.4 12.3,35.1 16.6,39.3 L46.5,69.4 C47.4,70.3 48.7,70.9 50.1,70.9 C51.4,70.9 52.7,70.4 53.7,69.4 L83.6,39.3 C87.8,35.1 90.2,29.4 90.2,23.4 C90.2,17.4 87.9,11.7 83.6,7.5 C79.2,3.3 73.5,1 67.5,1 Z"></path> </svg> <svg if="{type == \'save\'}" viewbox="0 0 72 88" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"> <path transform="translate(-15.000000, 0.000000)" d="M86.291,44.172 L86.291,8.734 C86.291,4.069 82.525,0.303 77.86,0.303 L24.114,0.303 C19.463,0.303 15.683,4.069 15.683,8.734 L15.683,44.171 L15.682,44.171 L15.682,87.949 L50.987,69.682 L86.292,87.949 L86.291,44.172 Z"></path> </svg> </div> <p class="text"> {count} </p> </a>', 'graphjs-star-button{display:inline-block;width:auto;height:50px;color:#6f879f;vertical-align:middle;-webkit-transition:background-color .35s ease;-moz-transition:background-color .35s ease;-ms-transition:background-color .35s ease;-o-transition:background-color .35s ease} graphjs-star-button:hover{background-color:white} graphjs-star-button a{display:inline-block;overflow:hidden;width:auto;height:48px;vertical-align:middle;-webkit-border-radius:inherit;-moz-border-radius:inherit;border-radius:inherit;-moz-background-clip:padding;-webkit-background-clip:padding-box;background-clip:padding-box} graphjs-star-button a .icon{display:block;float:left;position:relative;width:48px;height:48px;text-align:center;-webkit-border-radius:inherit;-moz-border-radius:inherit;border-radius:inherit;-moz-background-clip:padding;-webkit-background-clip:padding-box;background-clip:padding-box} graphjs-star-button a .icon.default svg path{fill:#a68b59} graphjs-star-button a .icon.like svg path{fill:#6d8fb0} graphjs-star-button a .icon.love svg{padding-top:3px;padding-bottom:1px} graphjs-star-button a .icon.love svg path{fill:#88686e} graphjs-star-button a .icon.save svg{padding-top:3px;padding-bottom:1px} graphjs-star-button a .icon.save svg path{fill:#696969} graphjs-star-button a .icon::before{content:\'\';display:block;position:absolute;top:50%;right:50%;bottom:50%;left:50%;width:0%;height:0%;vertical-align:middle;-webkit-border-radius:50%;-moz-border-radius:50%;border-radius:50%;-moz-background-clip:padding;-webkit-background-clip:padding-box;background-clip:padding-box;-webkit-transition:all .35s ease;-moz-transition:all .35s ease;-ms-transition:all .35s ease;-o-transition:all .35s ease} graphjs-star-button a .icon svg{display:inline-block;position:relative;width:50%;height:50%;margin:25%;vertical-align:middle} graphjs-star-button a .icon svg path{fill:#c0c0c0} graphjs-star-button a .text{display:block;float:left;width:auto;height:50px;margin:0;margin-right:15px;color:#6f879f;font-size:1.6em;line-height:51px;letter-spacing:.015em} graphjs-star-button a:hover .icon.default::before{background-color:rgba(255,165,0,0.15)} graphjs-star-button a:hover .icon.like::before{background-color:rgba(30,144,255,0.15)} graphjs-star-button a:hover .icon.love::before{background-color:rgba(220,20,60,0.15)} graphjs-star-button a:hover .icon.save::before{background-color:rgba(32,178,170,0.15)} graphjs-star-button a:hover .icon::before{top:-25%;right:-25%;bottom:-25%;left:-25%;width:150%;height:150%;background-color:rgba(192,192,192,0.15)} graphjs-star-button a.active .icon.default::before{background-color:orange} graphjs-star-button a.active .icon.default svg path{fill:orange} graphjs-star-button a.active .icon.like::before{background-color:dodgerblue} graphjs-star-button a.active .icon.like svg path{fill:dodgerblue} graphjs-star-button a.active .icon.love::before{background-color:crimson} graphjs-star-button a.active .icon.love svg path{fill:crimson} graphjs-star-button a.active .icon.save::before{background-color:lightseagreen} graphjs-star-button a.active .icon.save svg path{fill:lightseagreen} graphjs-star-button a.active .icon::before{top:50%;right:50%;bottom:50%;left:50%;width:0%;height:0%;background-color:silver} graphjs-star-button a.active .icon svg path{fill:silver}', 'class="box"', function(opts) {
'use strict';

var _this = this;

var _star = __webpack_require__(37);

var _star2 = _interopRequireDefault(_star);

var _getStar = __webpack_require__(38);

var _getStar2 = _interopRequireDefault(_getStar);

var _getStars = __webpack_require__(16);

var _getStars2 = _interopRequireDefault(_getStars);

var _removeStar = __webpack_require__(17);

var _removeStar2 = _interopRequireDefault(_removeStar);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

this.active = false;
this.type = opts.type || 'default';
this.count = 0;

this.on('before-mount', function () {
    var self = this;
    (0, _getStar2.default)(window.location.href, function (response) {
        if (response.success) {
            if (response.starred) {
                self.active = true;
            } else {
                self.active = false;
            }
            self.count = response.count;
            self.update();
        }
    });
});
this.handleStar = function (event) {
    event.preventDefault();
    var self = _this;
    if (!self.active) {
        self.active = true;
        self.count++;
        self.update();
        (0, _star2.default)(window.location.href, function (response) {
            if (!response.success) {
                self.active = false;
                self.count--;
            }
            self.count = response.count;
            self.update();
        });
    } else {
        self.active = false;
        self.count--;
        self.update();
        (0, _removeStar2.default)(window.location.href, function (response) {
            if (!response.success) {
                self.active = true;
                self.count++;
            }
            self.count = response.count;
            self.update();
        });
    }
};
});
    
  if (false) {
    module.hot.accept()
    if (module.hot.data) {
      riot.reload('graphjs-star-button')
    }
  }
  

/***/ }),
/* 101 */
/***/ (function(module, exports, __webpack_require__) {


    var riot = __webpack_require__(0)
    riot.tag2('graphjs-star-list', '<div class="header" if="{opts.title}"> <div class="title">{opts.title || \'Login\'}</div> </div> <div class="content"> <div class="bar"> <div class="search"> <div class="icon"> <svg viewbox="0 0 20 20" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"> <g transform="translate(-15.000000, -15.000000)" fill="black" fill-rule="nonzero"> <path d="M20.7680925,17.4466286 C17.9916599,20.2182136 17.582728,24.4722742 19.5628195,27.6735622 L15.5811138,31.6483159 C14.8062954,32.4217814 14.8062954,33.6464353 15.5811138,34.4199008 C16.3559322,35.1933664 17.582728,35.1933664 18.3575464,34.4199008 L22.3177294,30.4666324 C25.5246166,32.4217814 29.7861178,32.0350486 32.5625504,29.2634637 C35.8124832,26.0192053 35.8124832,20.7338573 32.5625504,17.4681138 C29.3126177,14.1808851 24.0180253,14.1808851 20.7680925,17.4466286 Z M30.1304816,26.7926709 C28.2149583,28.7048497 25.094162,28.7048497 23.1786387,26.7926709 C21.2631154,24.8804921 21.2631154,21.7651447 23.1786387,19.8529659 C25.094162,17.9407872 28.2149583,17.9407872 30.1304816,19.8529659 C32.0460048,21.7866298 32.0460048,24.8804921 30.1304816,26.7926709 Z" id="Shape" transform="translate(25.000000, 25.000000) scale(-1, 1) translate(-25.000000, -25.000000) "></path> </g> </svg> </div> <input onkeyup="{handleFilter}" type="text" placeholder="Search web addresses..."> </div> </div> <div class="list"> <div each="{matchedStar in matchedStars}" class="item" data-link="star" data-id="{matchedStar}" onclick="{opts.minor ? handleCallback : handleShow}" if="{matchedStars.length > 0}"> <div class="{type + \' icon\'}"> <svg if="{type == \'default\'}" viewbox="0 0 62 58" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"> <path transform="translate(-19.000000, 0.000000)" d="M78.55,20.92 L60,18.22 L51.41,0.88 C51.1430837,0.342731823 50.5949178,0.00297581751 49.995,0.00297581751 C49.3950822,0.00297581751 48.8469163,0.342731823 48.58,0.88 L40,18.22 L21.43,20.92 C20.7357885,21.0320591 20.1641226,21.5260416 19.9525703,22.1966625 C19.7410179,22.8672834 19.9257511,23.5998777 20.43,24.09 L33.86,37.2 L30.64,56 C30.5260197,56.6400466 30.78705,57.289052 31.3124543,57.6719377 C31.8378586,58.0548234 32.535622,58.1045341 33.11,57.8 L50,48.92 L66.89,57.8 C67.464378,58.1045341 68.1621414,58.0548234 68.6875457,57.6719377 C69.21295,57.289052 69.4739803,56.6400466 69.36,56 L66.14,37.2 L79.58,24.1 C80.0914811,23.6064567 80.2769729,22.8645697 80.0579562,22.1883821 C79.8389395,21.5121946 79.2537111,21.0199434 78.55,20.92 Z"></path> </svg> <svg if="{type == \'like\'}" viewbox="0 0 42 54" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"> <path transform="translate(-21.000000, 0.000000)" d="M62.973,24.929 C62.727,26.613 61.768,28.044 60.453,28.9 C60.152,29.099 59.844,29.372 59.515,29.619 L59.385,29.626 C60.631,31.886 60.487,33.536 59.042,35.693 C58.816,36.035 58.645,36.295 58.419,36.528 C59.74,39.253 58.994,42.499 56.666,44.327 C56.755,45.422 56.885,46.504 56.755,47.586 C56.399,50.729 54.099,52.92 50.778,53.31 C50.21,53.372 49.621,53.426 49.032,53.454 C48.635,53.475 48.224,53.488 47.813,53.495 C44.616,53.187 41.418,52.728 38.228,52.345 C35.25,51.996 32.285,51.489 29.088,50.955 C27.814,50.736 26.507,50.517 25.137,50.305 L25.137,50.305 C23.2995486,50.305 21.81,48.8154514 21.81,46.978 L21.81,30.584 C21.81,30.057 21.817,29.53 21.831,29.002 C21.831,28.858 21.838,28.714 21.838,28.571 C21.859,27.955 21.893,27.332 21.934,26.709 C22.064,24.648 25.275,24.429 26.597,23.827 C27.165,23.567 27.645,23.245 28.069,22.875 C28.24,22.731 28.404,22.574 28.562,22.416 C29.452,21.567 30.281,20.608 31.13,19.623 C31.349,19.377 31.561,19.123 31.774,18.884 C33.287,17.152 34.629,15.666 35.889,14.338 C36.587,13.599 37.183,12.791 37.683,11.901 C38.566,10.333 39.162,8.505 39.504,6.321 C39.689,5.123 39.853,3.808 39.997,2.322 C40.072,1.541 40.469,0.59 41.914,0.514 C43.229,0.452 44.495,0.822 45.591,1.507 C47.357,2.616 48.658,4.54 48.919,6.772 C49.124,8.497 48.905,10.23 48.221,12.386 C47.612,14.296 47.043,16.261 46.482,18.165 L46.044,19.671 L46.27,19.664 C48.146,19.568 50.022,19.472 51.898,19.37 C53.733,19.274 55.575,19.178 57.416,19.082 C57.614,19.075 57.813,19.062 58.012,19.048 C58.594,19.117 59.114,19.233 59.594,19.39 C59.772,19.445 59.93,19.513 60.08,19.582 C60.176,19.616 60.251,19.657 60.34,19.698 C60.402,19.732 60.463,19.78 60.518,19.814 C60.586,19.855 60.662,19.896 60.723,19.944 C60.798,20.006 60.874,20.054 60.935,20.108 C62.378,21.19 63.233,23.101 62.973,24.929 Z"></path> </svg> <svg if="{type == \'love\'}" viewbox="0 0 81 71" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"> <path transform="translate(-10.000000, 0.000000)" d="M67.5,1 C61.5,1 56.7,3.2 52.4,7.4 C52.4,7.4 52.4,7.4 52.4,7.4 L50,10.4 L47.6,7.5 C47.6,7.5 47.6,7.5 47.6,7.5 C47.6,7.5 47.6,7.5 47.6,7.5 C43.4,3.3 38.5,0.9 32.5,0.9 C26.5,0.9 20.8,3.2 16.6,7.5 C12.4,11.7 10,17.4 10,23.4 C10,29.4 12.3,35.1 16.6,39.3 L46.5,69.4 C47.4,70.3 48.7,70.9 50.1,70.9 C51.4,70.9 52.7,70.4 53.7,69.4 L83.6,39.3 C87.8,35.1 90.2,29.4 90.2,23.4 C90.2,17.4 87.9,11.7 83.6,7.5 C79.2,3.3 73.5,1 67.5,1 Z"></path> </svg> <svg if="{type == \'save\'}" viewbox="0 0 72 88" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"> <path transform="translate(-15.000000, 0.000000)" d="M86.291,44.172 L86.291,8.734 C86.291,4.069 82.525,0.303 77.86,0.303 L24.114,0.303 C19.463,0.303 15.683,4.069 15.683,8.734 L15.683,44.171 L15.682,44.171 L15.682,87.949 L50.987,69.682 L86.292,87.949 L86.291,44.172 Z"></path> </svg> </div> <div if="{scope == \'global\'}" class="count"> {starsData[matchedStar] && starsData[matchedStar].count} </div> <a class="title" href="{starsData[matchedStar] && starsData[matchedStar].url}"> {starsData[matchedStar].title || starsData[matchedStar].url} </a> <a if="{scope == \'user\'}" onclick="{handleRemove}" data-id="{matchedStar}" class="remove"> Delete </a> </div> <div class="placeholder item" if="{matchedStars.length <= 0}"> There isn\'t any star available. </div> </div> </div>', 'graphjs-star-list{display:block;color:rgba(63,95,127,0.65)} graphjs-star-list .content{padding-top:0 !important;padding-right:0 !important;padding-left:0 !important;padding-bottom:0 !important;padding:0 !important} graphjs-star-list .content .bar{display:table;width:100%;height:auto} graphjs-star-list .content .bar>*{float:left;border-radius:0} graphjs-star-list .content .bar .search{width:100%;background-color:#3899fa} graphjs-star-list .content .bar .search>*{float:left;border-radius:0} graphjs-star-list .content .bar .search .icon{width:3.5em;height:3.5em} graphjs-star-list .content .bar .search .icon svg{position:relative;width:1.3em;height:1.3em;margin:1.1em;vertical-align:middle} graphjs-star-list .content .bar .search .icon svg path{fill:white;-webkit-transition:fill .35s ease;-moz-transition:fill .35s ease;-ms-transition:fill .35s ease;-o-transition:fill .35s ease} graphjs-star-list .content .bar .search input{width:calc(100% - 3.5em);height:3.5em;padding-top:0;padding-right:0;padding-left:0;padding-bottom:0;padding:0;color:white;line-height:3.5em;border:none;background-color:transparent} graphjs-star-list .content .bar .search input::-webkit-input-placeholder,graphjs-star-list .content .bar .search input::placeholder{color:rgba(255,255,255,0.75)} graphjs-star-list .content .bar .search input::-moz-placeholder,graphjs-star-list .content .bar .search input:-ms-input-placeholder,graphjs-star-list .content .bar .search input:-moz-placeholder{color:rgba(255,255,255,0.75)} graphjs-star-list .content .bar .search input:focus::-webkit-input-placeholder,graphjs-star-list .content .bar .search input:focus::placeholder{opacity:.5} graphjs-star-list .content .bar .search input:focus::-moz-placeholder,graphjs-star-list .content .bar .search input:focus:-ms-input-placeholder,graphjs-star-list .content .bar .search input:focus:-moz-placeholder{opacity:.5} graphjs-star-list .content .list{display:inline-block;width:100%;height:auto;vertical-align:middle} graphjs-star-list .content .list .item{display:table;width:100%;color:#6f879f;line-height:3.5em;border-bottom:1px solid rgba(0,0,0,0.1)} graphjs-star-list .content .list .item:last-child{border-bottom:none} graphjs-star-list .content .list .item:hover{background-color:rgba(0,127,255,0.05)} graphjs-star-list .content .list .item:hover .remove{display:block} graphjs-star-list .content .list .item.placeholder{color:#9fafbf;text-align:center} graphjs-star-list .content .list .item>*{float:left} graphjs-star-list .content .list .item>*:first-child{border-left:none} graphjs-star-list .content .list .item .icon{display:block;float:left;position:relative;width:3.5em;height:3.5em;text-align:center;-webkit-border-radius:inherit;-moz-border-radius:inherit;border-radius:inherit;-moz-background-clip:padding;-webkit-background-clip:padding-box;background-clip:padding-box} graphjs-star-list .content .list .item .icon.default svg path{fill:orange} graphjs-star-list .content .list .item .icon.like svg path{fill:dodgerblue} graphjs-star-list .content .list .item .icon.love svg{padding-top:2px} graphjs-star-list .content .list .item .icon.love svg path{fill:crimson} graphjs-star-list .content .list .item .icon.save svg{padding-top:2px} graphjs-star-list .content .list .item .icon.save svg path{fill:lightseagreen} graphjs-star-list .content .list .item .icon svg{display:inline-block;position:relative;top:-2px;width:34%;height:33%;margin:33%;vertical-align:middle} graphjs-star-list .content .list .item .icon svg path{fill:silver} graphjs-star-list .content .list .item .count{width:7.5%;font-size:1.75em;text-align:left} graphjs-star-list .content .list .item .count+.title{width:calc(90% - 3.5em)} graphjs-star-list .content .list .item .count svg{width:auto;height:.75em;margin-right:.25em} graphjs-star-list .content .list .item .count svg path{fill:#6f879f} graphjs-star-list .content .list .item .title{cursor:pointer;width:calc(85% - 3.5em);color:#3f5f7f;overflow:hidden;text-overflow:ellipsis;white-space:nowrap} graphjs-star-list .content .list .item .title:hover::after{margin-left:.5em;opacity:1} graphjs-star-list .content .list .item .title::after{content:"\\2192";display:inline;margin-left:0;opacity:0;-webkit-transition:all .35s ease;-moz-transition:all .35s ease;-ms-transition:all .35s ease;-o-transition:all .35s ease} graphjs-star-list .content .list .item .remove{display:none;cursor:pointer;width:15%;text-align:right;padding-right:1.5em;color:#ff4f4f} graphjs-star-list .content .list .item .remove:hover{color:#ff6161} graphjs-star-list .content .list .item .remove:active{color:#e64747}', 'class="{opts.minor != true && \'box\'}"', function(opts) {
'use strict';

var _this = this;

var _getStars = __webpack_require__(16);

var _getStars2 = _interopRequireDefault(_getStars);

var _getUserStars = __webpack_require__(39);

var _getUserStars2 = _interopRequireDefault(_getUserStars);

var _removeStar = __webpack_require__(17);

var _removeStar2 = _interopRequireDefault(_removeStar);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

this.type = opts.type || 'default';
this.scope = opts.scope || 'global';
this.stars = [];
this.starsData = {};
this.matchedStars = [];

this.on('before-mount', function () {
    this.handleContent();
});

this.handleContent = function () {
    var self = _this;
    _this.scope == 'user' ? (0, _getUserStars2.default)(function (response) {
        self.handleResponse(response);
    }) : (0, _getStars2.default)(function (response) {
        self.handleResponse(response);
    });
};
this.handleResponse = function (response) {
    var self = _this;
    if (response.success) {
        self.stars = [];
        for (var _iterator = Object.keys(response.pages), _isArray = Array.isArray(_iterator), _i = 0, _iterator = _isArray ? _iterator : _iterator[Symbol.iterator]();;) {
            var _ref;

            if (_isArray) {
                if (_i >= _iterator.length) break;
                _ref = _iterator[_i++];
            } else {
                _i = _iterator.next();
                if (_i.done) break;
                _ref = _i.value;
            }

            var star = _ref;

            self.stars.push(star);
            self.starsData[star] = {
                url: star,
                title: response.pages[star].title && unescape(response.pages[star].title),
                count: response.pages[star].star_count
            };
        }
        self.matchedStars = self.stars;
        self.update();
    } else {
        //Handle error
    }
};
this.handleFilter = function (event) {
    var self = _this;
    self.matchedStars = self.stars.filter(function (item) {
        return self.starsData[item].url.includes(event.target.value);
    });
};
this.handleRemove = function (event) {
    event.preventDefault();
    var self = _this;
    (0, _removeStar2.default)(event.target.dataset.id, function (response) {
        if (response.success) {
            self.handleContent();
            self.update();
        } else {
            //Handle error
        }
    });
};
});
    
  if (false) {
    module.hot.accept()
    if (module.hot.data) {
      riot.reload('graphjs-star-list')
    }
  }
  

/***/ }),
/* 102 */
/***/ (function(module, exports, __webpack_require__) {


    var riot = __webpack_require__(0)
    riot.tag2('graphjs-comments', '<div class="header" if="{opts.title}"> <div class="title">{opts.title || \'Comments\'}</div> </div> <div class="content" ref="scrollingContent"> <div class="comment"> <textarea ref="composer" placeholder="Write your comment here..."></textarea> <button onclick="{handleComment}">Send Comment</button> <button onclick="{handleClear}" class="danger">Clear</button> </div> <div class="synopsis" if="{comments.length <= 0}"> Not comments yet. Be the first person to comment! </div> <div class="synopsis" if="{comments.length > 0}"> {comments.length <= 1 ? comments.length + \' comment\' : comments.length + \' comments\'} </div> <div each="{comment in comments}" data-id="{comment}" class="item"> <div class="credit" if="{authorsData.hasOwnProperty(commentsData[comment].author)}"> <img riot-src="{authorsData[commentsData[comment].author].avatar || \'lib/images/avatars/user.png\'}"> <span> <b>{authorsData[commentsData[comment].author].username || \'Unknown User\'}</b> <time>{handleTime(commentsData[comment].createTime) || \'\'}</time> <a if="{commentsData[comment].author == userId}" onclick="{handleRemove}" data-id="{comment}">Delete</a> </span> </div> <p>{commentsData[comment].content}</p> </div> </div>', 'graphjs-comments{display:block;color:rgba(63,95,127,0.65);background-color:#f5f7f9} graphjs-comments .comment{display:inline-block;width:100%;margin-bottom:1.25em} graphjs-comments .comment textarea{width:100%;height:7.5em} graphjs-comments .comment textarea.closed{height:0;border:none} graphjs-comments .comment button{float:right;width:auto;margin-top:.5em;margin-left:.5em;font-size:.9em} graphjs-comments .synopsis{display:inline-block;width:100%;margin-bottom:1.25em} graphjs-comments .synopsis button{float:right;width:auto;font-size:.75em} graphjs-comments .item{margin-bottom:1.25em} graphjs-comments .item:last-child{margin-bottom:0} graphjs-comments .item .credit{height:3em;margin-bottom:.25em} graphjs-comments .item .credit img{width:3em;height:3em} graphjs-comments .item .credit span{color:red;height:3em;margin-left:.6em;padding:.375em 0} graphjs-comments .item .credit span b{font-size:1.125em !important} graphjs-comments .item .credit span small,graphjs-comments .item .credit span time{font-size:.975em !important} graphjs-comments .item .credit span{color:#6f879f} graphjs-comments .item p{margin-left:48px !important;font-family:"Rubik";font-weight:400;font-size:.95em;line-height:150%}', 'class="box"', function(opts) {
'use strict';

var _this = this;

var _getComments = __webpack_require__(103);

var _getComments2 = _interopRequireDefault(_getComments);

var _addComment = __webpack_require__(104);

var _addComment2 = _interopRequireDefault(_addComment);

var _removeComment = __webpack_require__(105);

var _removeComment2 = _interopRequireDefault(_removeComment);

var _getUser = __webpack_require__(6);

var _getUser2 = _interopRequireDefault(_getUser);

var _getProfile = __webpack_require__(7);

var _getProfile2 = _interopRequireDefault(_getProfile);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

this.page = 1;
this.pageLimit = 10;
this.comments = [];
this.commentsData = {};
this.authorsData = {};

this.on('before-mount', function () {
    this.handleUser();
    this.handleContent();
});

this.handleUser = function () {
    var self = _this;
    (0, _getUser2.default)(function (response) {
        if (response.success) {
            self.userId = response.id;
        } else {
            //Handle errors
        }
    });
};
this.handleContent = function (callback) {
    var self = _this;
    (0, _getComments2.default)(window.location.href, function (response) {
        if (response.success) {
            self.comments = [];

            var _loop = function _loop() {
                if (_isArray) {
                    if (_i >= _iterator.length) return 'break';
                    _ref = _iterator[_i++];
                } else {
                    _i = _iterator.next();
                    if (_i.done) return 'break';
                    _ref = _i.value;
                }

                var comment = _ref;

                var key = Object.keys(comment)[0];
                self.comments.push(key);
                self.commentsData[key] = comment[key];
                callback && callback();
                (0, _getProfile2.default)(comment[key].author, function (response) {
                    if (response.success) {
                        self.authorsData[comment[key].author] = response.profile;
                    }
                    self.update();
                });
            };

            for (var _iterator = response.comments, _isArray = Array.isArray(_iterator), _i = 0, _iterator = _isArray ? _iterator : _iterator[Symbol.iterator]();;) {
                var _ref;

                var _ret = _loop();

                if (_ret === 'break') break;
            }
            self.update();
        }
    });
};
this.handleClear = function (event) {
    event.preventDefault();
    _this.refs.composer.value = '';
    _this.refs.composer.focus();
};
this.handleComment = function (event) {
    event.preventDefault();
    var self = _this;
    (0, _addComment2.default)(window.location.href, self.refs.composer.value, function (response) {
        if (response.success) {
            self.handleContent(function () {
                self.refs.scrollingContent.scrollTop = self.refs.scrollingContent.scrollHeight;
            });
            self.refs.composer.value = '';
            self.update();
        } else {
            //Handle error
        }
    });
};
this.handleRemove = function (event) {
    event.preventDefault();
    var self = _this;
    (0, _removeComment2.default)(event.target.dataset.id, function (response) {
        if (response.success) {
            self.handleContent();
            self.update();
        } else {
            //Handle error
        }
    });
};
this.handleTime = function (timestamp) {
    var date = new Date(parseInt(timestamp) * 1000);
    var day = date.getDate();
    var month = _this.months[date.getMonth()];
    var year = date.getFullYear();
    var hour = date.getHours();
    var minute = date.getMinutes();
    return month + ' ' + day + ', ' + year + ' · ' + hour + ':' + minute;
};
this.months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
});
    
  if (false) {
    module.hot.accept()
    if (module.hot.data) {
      riot.reload('graphjs-comments')
    }
  }
  

/***/ }),
/* 103 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


Object.defineProperty(exports, "__esModule", {
	value: true
});

exports.default = function () {
	var args = Array.from(arguments);
	var callback = args.pop();
	getCommentsCall(args, callback);
};

var _api = __webpack_require__(1);

var _api2 = _interopRequireDefault(_api);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function getCommentsCall(args, callback) {
	(0, _api2.default)("getComments", {
		"url": args[0]
	}, function (response) {
		callback(response.data);
	});
};

;

/***/ }),
/* 104 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


Object.defineProperty(exports, "__esModule", {
	value: true
});

exports.default = function () {
	var args = Array.from(arguments);
	var callback = args.pop();
	addCommentCall(args, callback);
};

var _api = __webpack_require__(1);

var _api2 = _interopRequireDefault(_api);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function addCommentCall(args, callback) {
	(0, _api2.default)("addComment", {
		"url": args[0],
		"content": args[1]
	}, function (response) {
		callback(response.data);
	});
};

;

/***/ }),
/* 105 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


Object.defineProperty(exports, "__esModule", {
	value: true
});

exports.default = function () {
	var args = Array.from(arguments);
	var callback = args.pop();
	removeCommentCall(args, callback);
};

var _api = __webpack_require__(1);

var _api2 = _interopRequireDefault(_api);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function removeCommentCall(args, callback) {
	(0, _api2.default)("removeComment", {
		"comment_id": args[0]
	}, function (response) {
		callback(response.data);
	});
};

;

/***/ }),
/* 106 */
/***/ (function(module, exports, __webpack_require__) {


    var riot = __webpack_require__(0)
    riot.tag2('graphjs-forum', '<graphjs-forum-list minor="{true}" title="{opts.title}" callback="{changeProperties}" if="{this.active == \'list\'}"></graphjs-forum-list> <graphjs-forum-thread minor="{true}" title="{opts.title}" id="{id}" callback="{changeProperties}" if="{this.active == \'thread\'}"></graphjs-forum-thread> <graphjs-forum-compose minor="{true}" title="{opts.title}" callback="{changeProperties}" if="{this.active == \'compose\'}"></graphjs-forum-compose>', 'graphjs-forum{display:block;width:800px;color:rgba(63,95,127,0.65)}', 'class="box"', function(opts) {
'use strict';

var _this = this;

__webpack_require__(40);

__webpack_require__(43);

__webpack_require__(46);

this.active = 'list';
this.id = undefined;
this.changeProperties = function (properties) {
    _this.active = properties.link || undefined;
    _this.id = properties.id || undefined;
    _this.update();
};
});
    
  if (false) {
    module.hot.accept()
    if (module.hot.data) {
      riot.reload('graphjs-forum')
    }
  }
  

/***/ }),
/* 107 */
/***/ (function(module, exports, __webpack_require__) {


    var riot = __webpack_require__(0)
    riot.tag2('graphjs-group', '<graphjs-group-header id="{opts.id}" minor="{true}" callback="{changeProperties}"></graphjs-group-header> <graphjs-group-activity minor="{true}" callback="{changeProperties}" if="{this.active == \'activity\'}"></graphjs-group-activity> <graphjs-group-members id="{opts.id}" minor="{true}" callback="{changeProperties}" if="{this.active == \'members\'}"></graphjs-group-members> <graphjs-group-settings id="{opts.id}" minor="{true}" callback="{changeProperties}" if="{this.active == \'settings\'}"></graphjs-group-settings>', 'graphjs-group{display:block;width:48em;margin:0 auto}', '', function(opts) {
'use strict';

var _this = this;

__webpack_require__(48);

__webpack_require__(51);

__webpack_require__(52);

this.active = opts.default || 'members';
this.changeProperties = function (event) {
    _this.active = event.currentTarget.dataset.link;
    _this.update();
};
});
    
  if (false) {
    module.hot.accept()
    if (module.hot.data) {
      riot.reload('graphjs-group')
    }
  }
  

/***/ }),
/* 108 */
/***/ (function(module, exports, __webpack_require__) {


    var riot = __webpack_require__(0)
    riot.tag2('graphjs-group-card', '<div class="information" if="{group}"> <img riot-src="{group.cover || \'lib/images/covers/group.png\'}"> <a data-link="group" data-id="{id}" onclick="{handleShow}" if="{group}">{group.title}</a> <p>{group.count == 1 ? group.count + \' Member\' : group.count + \' Members\'}</p> </div> <div class="information" if="{!group}"> <img src="lib/images/covers/group.png"> <a>Group doesn\'t exist.</a> <p>We couldn\'t find any group matching this id.</p> </div> <button if="{group}" onclick="{joined ? handleLeave : handleJoin}">{joined ? \'Leave Group\' : \'Join Group\'}</button> <button if="{!group}" onclick="{handleUpdate}">Refresh</button>', 'graphjs-group-card{display:block;color:rgba(63,95,127,0.65)} graphjs-group-card .information img{width:15em;height:8.4375em} graphjs-group-card .information a{display:inline-block;overflow:hidden;width:90%;max-height:2.5em;margin:0 5%;margin-top:.5em;font-size:1.2em;line-height:1.25em;font-family:"Rubik";font-weight:800;color:#007fff} graphjs-group-card .information a:hover{color:#198cff} graphjs-group-card .information a:active{color:#0072e6} graphjs-group-card .information p{display:inline-block;overflow:hidden;width:90%;max-height:2.5em;margin:0 5%;margin-top:.75em;color:#6f879f;font-size:.95em;line-height:1.25em}', 'class="card box"', function(opts) {
'use strict';

var _this = this;

var _getGroup = __webpack_require__(49);

var _getGroup2 = _interopRequireDefault(_getGroup);

var _joinGroup = __webpack_require__(20);

var _joinGroup2 = _interopRequireDefault(_joinGroup);

var _leaveGroup = __webpack_require__(50);

var _leaveGroup2 = _interopRequireDefault(_leaveGroup);

var _showGroup = __webpack_require__(21);

var _showGroup2 = _interopRequireDefault(_showGroup);

var _getUser = __webpack_require__(6);

var _getUser2 = _interopRequireDefault(_getUser);

var _listMembers = __webpack_require__(12);

var _listMembers2 = _interopRequireDefault(_listMembers);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

this.id = opts.id;
this.members = opts.id;

this.on('before-mount', function () {
    this.handleInformation();
    this.handleMembers();
});
this.on('mount', function () {
    opts.theme && this.root.classList.add(opts.theme);
});

this.handleInformation = function () {
    var self = _this;
    (0, _getGroup2.default)(self.id, function (response) {
        if (response.success) {
            self.group = response.group;
            self.update();
        } else {
            //Handle errors
        }
    });
};
this.handleMembers = function () {
    var self = _this;
    (0, _listMembers2.default)(self.id, function (response) {
        if (response.success) {
            self.members = response.members;
            self.update();
            (0, _getUser2.default)(function (response) {
                if (response.success) {
                    self.joined = self.members.includes(response.id);
                    self.update();
                } else {
                    //Handle errors
                }
            });
        } else {
            //Handle errors
        }
    });
};
this.handleShow = function (event) {
    event.preventDefault();
    var dataset = event.currentTarget.dataset;
    switch (dataset.link) {
        case 'group':
            (0, _showGroup2.default)({
                id: dataset.id,
                scroll: true
            });
            break;
    }
};
this.handleJoin = function () {
    var self = _this;
    (0, _joinGroup2.default)(self.id, function (response) {
        if (response.success) {
            self.joined = true;
            self.update();
        } else {
            //Handle errors
        }
    });
};
this.handleLeave = function () {
    var self = _this;
    (0, _leaveGroup2.default)(self.id, function (response) {
        if (response.success) {
            self.joined = false;
            self.update();
        } else {
            //Handle errors
        }
    });
};
this.handleUpdate = function () {
    return _this.update();
};
});
    
  if (false) {
    module.hot.accept()
    if (module.hot.data) {
      riot.reload('graphjs-group-card')
    }
  }
  

/***/ }),
/* 109 */
/***/ (function(module, exports, __webpack_require__) {


    var riot = __webpack_require__(0)
    riot.tag2('graphjs-group-settings', '<h1>settings</h1>', '', '', function(opts) {
});
    
  if (false) {
    module.hot.accept()
    if (module.hot.data) {
      riot.reload('graphjs-group-settings')
    }
  }
  

/***/ }),
/* 110 */
/***/ (function(module, exports, __webpack_require__) {


    var riot = __webpack_require__(0)
    riot.tag2('graphjs-messages', '<div class="header"> <div class="title">{this.activePartnerName.length > 0 ? \'Messages with \' +  this.activePartnerName : \'Messages\'}</div> <a class="option left" onclick="{handleNewMessage}"> <svg class="{newMessageOption ? \'\' : \'new\'}" viewbox="0 0 30 30" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"> <path transform="translate(-755.000000, -15.000000)" d="M768.138179,30.0276818 L763.8,25.6895028 L765.689503,23.8 L770.011119,28.1447263 L774.332735,23.8 L776.222238,25.6895028 L771.884059,30.0276818 L771.888398,30.0320442 L771.884064,30.0363784 L776.222238,34.3414365 L774.332735,36.2309392 L770.011119,31.9093232 L765.689503,36.2309392 L763.8,34.3414365 L768.138174,30.0363784 L768.13384,30.0320442 L768.138179,30.0276818 Z M769.983425,15 C778.270718,15 785,21.6961326 785,29.9834254 C785,38.2707182 778.270718,45 769.983425,45 C761.696133,45 755,38.2707182 755,29.9834254 C755,21.6961326 761.696133,15 769.983425,15 Z M769.983425,42.3480663 C776.779006,42.3480663 782.348066,36.8121547 782.348066,29.9834254 C782.348066,23.1878453 776.812155,17.6187845 769.983425,17.6187845 C763.187845,17.6187845 757.618785,23.1546961 757.618785,29.9834254 C757.651934,36.7790055 763.187845,42.3480663 769.983425,42.3480663 Z"></path> </svg> </a> </div> <div class="content"> <div class="sidebar"> <input ref="searchForPartners" onkeyup="{handleFilter}" class="{!newMessageOption && \'hidden\'}" type="text" placeholder="Type a name..."> <div class="suggestions" if="{newMessageOption && matchedPartners.length > 0}"> <a each="{matchedPartner in matchedPartners}" data-id="{matchedPartner.id}" onclick="{handleNewPartner}"> <img riot-src="{matchedPartner.avatar || \'lib/images/avatars/user.png\'}"> <b>{matchedPartner.username}</b> </a> </div> <div class="list" ref="partners"> <a class="{list[partner] && list[partner].is_read ? \'item\' : \'unread item\'}" each="{partner in partners}" data-partner="{partner}" onclick="{handleDisplay}"> <img riot-src="{list[partner] && list[partner].avatar ? list[partner].avatar : \'lib/images/avatars/user.png\'}"> <div> <b>{list[partner] && list[partner].username}</b> {list[partner] && list[partner].message} </div> </a> </div> </div> <div class="main"> <div class="conversation" ref="messages"> <div class="{activeMessages[message].to == userId ? \'inbound item\' : \'outbound item\'}" each="{message in messages}" data-message="{message}"> <div> <p>{activeMessages[message].message}</p> </div> <time data-timestamp="{activeMessages[message].timestamp}"></time> </div> </div> <textarea onselect="{handleTextSelection}" onclick="{handleTextSelection}" onkeyup="{handleSubmit}" placeholder="Write your message here..."></textarea> </div> </div>', 'graphjs-messages{display:block;width:800px;color:rgba(63,95,127,0.65);font-family:"Rubik";font-weight:400} graphjs-messages .content{height:37em;max-height:37em;padding-top:0 !important;padding-right:0 !important;padding-left:0 !important;padding-bottom:0 !important;padding:0 !important;vertical-align:middle} graphjs-messages .content>*{float:left} graphjs-messages .content .sidebar{overflow-y:scroll;width:15em;height:100%;-webkit-box-shadow:inset -2px 0 2px 0 rgba(0,0,0,0.05);-moz-box-shadow:inset -2px 0 2px 0 rgba(0,0,0,0.05);box-shadow:inset -2px 0 2px 0 rgba(0,0,0,0.05)} graphjs-messages .content .sidebar input{display:block;width:100%;height:3.5em;padding-top:0;padding-right:1.5em;padding-bottom:0;padding-left:1.5em;color:white;line-height:3.5em;border:none;border-radius:0;background-color:#007fff;-webkit-transition:height .35s ease;-moz-transition:height .35s ease;-ms-transition:height .35s ease;-o-transition:height .35s ease} graphjs-messages .content .sidebar input::-webkit-input-placeholder,graphjs-messages .content .sidebar input::placeholder{color:rgba(255,255,255,0.75)} graphjs-messages .content .sidebar input::-moz-placeholder,graphjs-messages .content .sidebar input:-ms-input-placeholder,graphjs-messages .content .sidebar input:-moz-placeholder{color:rgba(255,255,255,0.75)} graphjs-messages .content .sidebar input:focus::-webkit-input-placeholder,graphjs-messages .content .sidebar input:focus::placeholder{opacity:.5} graphjs-messages .content .sidebar input:focus::-moz-placeholder,graphjs-messages .content .sidebar input:focus:-ms-input-placeholder,graphjs-messages .content .sidebar input:focus:-moz-placeholder{opacity:.5} graphjs-messages .content .sidebar input.hidden{height:0} graphjs-messages .content .sidebar input.hidden::-webkit-input-placeholder,graphjs-messages .content .sidebar input.hidden::placeholder{color:transparent} graphjs-messages .content .sidebar input.hidden::-moz-placeholder,graphjs-messages .content .sidebar input.hidden:-ms-input-placeholder,graphjs-messages .content .sidebar input.hidden:-moz-placeholder{color:transparent} graphjs-messages .content .sidebar input.hidden:focus::-webkit-input-placeholder,graphjs-messages .content .sidebar input.hidden:focus::placeholder{opacity:.5} graphjs-messages .content .sidebar input.hidden:focus::-moz-placeholder,graphjs-messages .content .sidebar input.hidden:focus:-ms-input-placeholder,graphjs-messages .content .sidebar input.hidden:focus:-moz-placeholder{opacity:.5} graphjs-messages .content .sidebar input::placeholder{opacity:.5;-webkit-transition:all .35s ease;-moz-transition:all .35s ease;-ms-transition:all .35s ease;-o-transition:all .35s ease} graphjs-messages .content .sidebar .suggestions{max-height:17.5em;overflow-y:scroll;background-color:rgba(0,0,0,0.075)} graphjs-messages .content .sidebar .suggestions a{display:block;width:100%;height:3.5em;padding:.5em;color:white;border-top:1px solid rgba(0,0,0,0.05)} graphjs-messages .content .sidebar .suggestions a::after{content:"";display:table;clear:both} graphjs-messages .content .sidebar .suggestions a>*{float:left;pointer-events:none} graphjs-messages .content .sidebar .suggestions a img{width:2.5em;height:2.5em;-webkit-border-radius:50%;-moz-border-radius:50%;border-radius:50%;-moz-background-clip:padding;-webkit-background-clip:padding-box;background-clip:padding-box} graphjs-messages .content .sidebar .suggestions a b{color:#6f879f;height:2.5em;margin-left:.5em;line-height:2.5em;overflow:hidden;text-overflow:ellipsis;white-space:nowrap} graphjs-messages .content .sidebar .list .item{display:table;width:100%;height:4.5em;padding:calc(.75em - 1px);padding-bottom:calc(.75em + 1px);border-top:1px solid rgba(0,0,0,0.025);border-bottom:1px solid rgba(63,95,127,0.025)} graphjs-messages .content .sidebar .list .item:hover{background-color:rgba(0,127,255,0.05)} graphjs-messages .content .sidebar .list .item:last-child{border-bottom:none} graphjs-messages .content .sidebar .list .item.unread div{color:#5c99d6} graphjs-messages .content .sidebar .list .item.unread div b{color:#007fff} graphjs-messages .content .sidebar .list .item.active{border-right:none;background-color:white !important;-webkit-box-shadow:0 0 5px 0 rgba(0,0,0,0.075);-moz-box-shadow:0 0 5px 0 rgba(0,0,0,0.075);box-shadow:0 0 5px 0 rgba(0,0,0,0.075)} graphjs-messages .content .sidebar .list .item>*{pointer-events:none} graphjs-messages .content .sidebar .list .item img{width:calc(3em + 1px);height:calc(3em + 1px);-webkit-border-radius:50%;-moz-border-radius:50%;border-radius:50%;-moz-background-clip:padding;-webkit-background-clip:padding-box;background-clip:padding-box} graphjs-messages .content .sidebar .list .item div{display:inline-block;overflow:hidden;width:11.11111111em;height:3.33333333em;margin-left:calc(.5em / .9);color:#6f879f;font-size:.9em;line-height:1.11111111em} graphjs-messages .content .sidebar .list .item div b{display:block;margin-bottom:.05555556em;color:#3f5f7f;font-size:1.05555556em;line-height:1.05555556em;font-family:"Rubik";font-weight:700;overflow:hidden;text-overflow:ellipsis;white-space:nowrap} graphjs-messages .content .main{overflow-y:scroll;position:relative;width:calc(100% - 15em);height:100%;background-color:white} graphjs-messages .content .main .conversation{overflow:scroll;width:100%;height:calc(100% - 6.5em);padding:2em} graphjs-messages .content .main .conversation .item{width:90%;height:auto;margin-bottom:.5em} graphjs-messages .content .main .conversation .item:last-of-type{margin-bottom:0} graphjs-messages .content .main .conversation .item.inbound{margin-right:10%} graphjs-messages .content .main .conversation .item.inbound div{text-align:left} graphjs-messages .content .main .conversation .item.inbound p{color:#6f879f;background-color:#f5f7f9} graphjs-messages .content .main .conversation .item.inbound time{text-align:left} graphjs-messages .content .main .conversation .item.outbound{margin-left:10%} graphjs-messages .content .main .conversation .item.outbound div{text-align:right} graphjs-messages .content .main .conversation .item.outbound p{color:white;background-color:#007fff;-webkit-border-radius:6px;-moz-border-radius:6px;border-radius:6px;-moz-background-clip:padding;-webkit-background-clip:padding-box;background-clip:padding-box} graphjs-messages .content .main .conversation .item.outbound time{text-align:right} graphjs-messages .content .main .conversation .item div+div{margin-top:.5em} graphjs-messages .content .main .conversation .item p{display:inline-block;width:auto;padding:.75em 1em;word-break:break-word;white-space:pre-wrap;-webkit-border-radius:6px;-moz-border-radius:6px;border-radius:6px;-moz-background-clip:padding;-webkit-background-clip:padding-box;background-clip:padding-box} graphjs-messages .content .main .conversation .item time{display:inline-block;width:100%;padding:.5em;color:#9fafbf;font-size:.85em;line-height:.85em} graphjs-messages .content .main .conversation .item time.error{color:#ff4f4f} graphjs-messages .content .main textarea{position:absolute;right:0;bottom:0;left:0;height:6.5em;line-height:1.25em;-webkit-border-radius:0;-moz-border-radius:0;border-radius:0;-moz-background-clip:padding;-webkit-background-clip:padding-box;background-clip:padding-box;border-right:none;border-bottom:none;border-left:none}', 'class="box"', function(opts) {
'use strict';

var _this = this;

var _getConversations = __webpack_require__(53);

var _getConversations2 = _interopRequireDefault(_getConversations);

var _getConversation = __webpack_require__(54);

var _getConversation2 = _interopRequireDefault(_getConversation);

var _getUser = __webpack_require__(6);

var _getUser2 = _interopRequireDefault(_getUser);

var _getProfile = __webpack_require__(7);

var _getProfile2 = _interopRequireDefault(_getProfile);

var _sendMessage = __webpack_require__(55);

var _sendMessage2 = _interopRequireDefault(_sendMessage);

var _getMembers = __webpack_require__(56);

var _getMembers2 = _interopRequireDefault(_getMembers);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

this.handleConversations = function () {
    var self = _this;
    (0, _getConversations2.default)(function (response) {
        if (response.success) {
            self.handleList(response.messages);
        } else {
            //Handle errors
        }
    });
};
this.handleConversation = function (id) {
    var self = _this;
    (0, _getConversation2.default)(id, function (response) {
        if (response.success) {
            self.activePartner = id;
            self.activeMessages = response.messages;
            self.messages = Object.keys(self.activeMessages).reverse();
            self.update();
            self.handleTime();
            self.update();
        } else {
            //Handle errors
        }
    });
};
this.handleList = function (messages) {
    var self = _this;
    self.list = [];
    self.partners = Object.keys(messages).reverse();

    var _loop = function _loop() {
        if (_isArray) {
            if (_i >= _iterator.length) return 'break';
            _ref = _iterator[_i++];
        } else {
            _i = _iterator.next();
            if (_i.done) return 'break';
            _ref = _i.value;
        }

        var partner = _ref;

        (0, _getProfile2.default)(partner, function (response) {
            if (response.success) {
                var item = {
                    partner: partner,
                    avatar: response.profile.avatar,
                    username: response.profile.username,
                    message: messages[partner].message,
                    is_read: messages[partner].is_read
                };
                self.list[partner] = item;
            } else {
                //Handle errors
            }
            self.update();
        });
    };

    for (var _iterator = self.partners, _isArray = Array.isArray(_iterator), _i = 0, _iterator = _isArray ? _iterator : _iterator[Symbol.iterator]();;) {
        var _ref;

        var _ret = _loop();

        if (_ret === 'break') break;
    }
};
this.handleTime = function () {
    var items = document.querySelectorAll('graphjs-messages time');
    var text = void 0;
    for (var _iterator2 = items, _isArray2 = Array.isArray(_iterator2), _i2 = 0, _iterator2 = _isArray2 ? _iterator2 : _iterator2[Symbol.iterator]();;) {
        var _ref2;

        if (_isArray2) {
            if (_i2 >= _iterator2.length) break;
            _ref2 = _iterator2[_i2++];
        } else {
            _i2 = _iterator2.next();
            if (_i2.done) break;
            _ref2 = _i2.value;
        }

        var item = _ref2;

        if (item.dataset.hasOwnProperty('timestamp')) {
            var timestamp = item.dataset.timestamp;
            var time = Math.floor((Date.now() - parseInt(timestamp) * 1000) / 1000);
            var amount = void 0;
            if (time < 1) {
                amount = time;
                text = 'Now';
            } else if (1 <= time && time < 60) {
                amount = time;
                text = amount == 1 ? amount + ' second' : amount + ' seconds';
            } else if (60 <= time && time < 60 * 60) {
                amount = Math.floor(time / 60);
                text = amount == 1 ? amount + ' minute' : amount + ' minutes';
            } else if (60 * 60 <= time && time < 60 * 60 * 24) {
                amount = Math.floor(time / 60 / 60);
                text = amount == 1 ? amount + ' hour' : amount + ' hours';
            } else if (60 * 60 * 24 <= time && time < 60 * 60 * 24 * 7) {
                amount = Math.floor(time / 60 / 60 / 24);
                text = amount == 1 ? amount + ' day' : amount + ' days';
            } else if (60 * 60 * 24 * 7 <= time && time < 60 * 60 * 24 * 30) {
                amount = Math.floor(time / 60 / 60 / 24 / 7);
                text = amount == 1 ? amount + ' week' : amount + ' weeks';
            } else if (60 * 60 * 24 * 30 <= time && time < 60 * 60 * 24 * 30 * 12) {
                amount = Math.floor(time / 60 / 60 / 24 / 30);
                text = amount == 1 ? amount + ' month' : amount + ' months';
            } else if (time >= 60 * 60 * 24 * 30 * 12) {
                amount = Math.floor(time / 60 / 60 / 24 / 30 / 12);
                text = amount == 1 ? amount + ' year' : amount + ' years';
            } else {
                //Handle errors
            }
        } else {
            text = 'Error: Couldn\'t send message';
            item.classList.add('error');
        }
        item.innerHTML = text;
    }
};
this.handleSubmit = function (event) {
    var self = _this;
    if (event.keyCode == 13) {
        event.preventDefault();
        var value = event.target.value.replace(/\n+/g, '\n'); // Removes repetitive line breaks
        if (!event.shiftKey) {
            event.target.value = '';
            var randomNumber = Math.floor(Math.random() * 1000000);
            self.activeMessages[randomNumber] = { from: _this.userId, is_read: false, message: value, timestamp: false, to: _this.activePartner };
            self.messages.push(randomNumber);
            self.refs.messages.scrollTop = self.refs.messages.scrollHeight;
            self.partners.sort(function (x, y) {
                return x == self.activePartner ? -1 : y == self.activePartner ? 1 : 0;
            });
            self.update();
            var anchors = self.refs.partners.children;
            for (var _iterator3 = anchors, _isArray3 = Array.isArray(_iterator3), _i3 = 0, _iterator3 = _isArray3 ? _iterator3 : _iterator3[Symbol.iterator]();;) {
                var _ref3;

                if (_isArray3) {
                    if (_i3 >= _iterator3.length) break;
                    _ref3 = _iterator3[_i3++];
                } else {
                    _i3 = _iterator3.next();
                    if (_i3.done) break;
                    _ref3 = _i3.value;
                }

                var anchor = _ref3;

                anchor.classList.remove('active');
            }
            var anchorsBox = self.refs.partners;
            anchorsBox.firstElementChild.classList.add('active') || anchorsBox.firstElementChild.classList.add('active');
            var box = anchorsBox.firstElementChild.lastElementChild;
            var title = box.firstElementChild;
            var text = document.createTextNode(value);
            box.innerHTML = '';
            box.appendChild(title);
            box.appendChild(text);
            (0, _sendMessage2.default)(self.activePartner, value, function (response) {
                if (response.success) {
                    self.handleConversation(self.activePartner);
                } else {
                    //Handle errors
                }
            });
        }
    }
};
this.handleDisplay = function (event) {
    var anchors = _this.refs.partners.children;
    _this.newMessageOption = false;
    _this.matchedPartners = [];
    for (var _iterator4 = anchors, _isArray4 = Array.isArray(_iterator4), _i4 = 0, _iterator4 = _isArray4 ? _iterator4 : _iterator4[Symbol.iterator]();;) {
        var _ref4;

        if (_isArray4) {
            if (_i4 >= _iterator4.length) break;
            _ref4 = _iterator4[_i4++];
        } else {
            _i4 = _iterator4.next();
            if (_i4.done) break;
            _ref4 = _i4.value;
        }

        var anchor = _ref4;

        anchor.classList.remove('active');
    }
    event.target.classList.hasOwnProperty('unread') || event.target.classList.remove('unread');
    event.target.classList.hasOwnProperty('active') || event.target.classList.add('active');
    var id = event.target.dataset.partner;
    _this.handleConversation(id);
    _this.handleTitle(id);
};
this.handleNewMessage = function (event) {
    _this.refs.searchForPartners.value = '';
    _this.matchedPartners = [];
    _this.newMessageOption = _this.newMessageOption ? false : true;
    _this.newMessageOption && _this.refs.searchForPartners.focus();
    _this.handlePossiblePartners();
    _this.update();
};
this.handlePossiblePartners = function () {
    var self = _this;
    Object.keys(self.possiblePartners).length > 0 || (0, _getMembers2.default)(function (response) {
        if (response.success) {
            self.possiblePartnersData = response.members;
            for (var _iterator5 = Object.keys(response.members), _isArray5 = Array.isArray(_iterator5), _i5 = 0, _iterator5 = _isArray5 ? _iterator5 : _iterator5[Symbol.iterator]();;) {
                var _ref5;

                if (_isArray5) {
                    if (_i5 >= _iterator5.length) break;
                    _ref5 = _iterator5[_i5++];
                } else {
                    _i5 = _iterator5.next();
                    if (_i5.done) break;
                    _ref5 = _i5.value;
                }

                var member = _ref5;

                var item = {
                    id: member,
                    username: response.members[member].username,
                    avatar: response.members[member].avatar
                };
                self.possiblePartners.push(item);
            }
            self.update();
        } else {
            //Handle error
        }
    });
};
this.handleFilter = function (event) {
    var self = _this;
    self.matchedPartners = self.possiblePartners.filter(function (item) {
        return item.username.startsWith(event.target.value);
    });
};
this.handleNewPartner = function (event) {
    _this.newMessageOption = false;
    var partner = event.target.dataset.id;
    var data = _this.possiblePartnersData[partner];
    var message = void 0;
    if (_this.partners.includes(partner)) {
        var index = _this.partners.indexOf(partner);
        _this.partners.splice(index, 1);
        message = _this.list[partner].message || '';
    }
    _this.partners.unshift(partner);
    _this.list[partner] = {
        partner: partner,
        avatar: data.avatar,
        username: data.username,
        message: message,
        is_read: true
    };
    var query = '.list a[data-partner="' + partner + '"]';
    _this.update();
    document.querySelectorAll(query).length > 0 && document.querySelectorAll(query)[0].click();
};
this.handleUser = function () {
    var self = _this;
    (0, _getUser2.default)(function (response) {
        if (response.success) {
            self.userId = response.id;
        } else {
            //Handle errors
        }
    });
};
this.handleTitle = function (id) {
    var query = 'a[data-partner="' + id + '"] b';
    _this.activePartnerName = document.querySelectorAll(query) ? document.querySelectorAll(query)[0].innerHTML : '';
    _this.update();
};

this.userId = '';
this.activePartner = '';
this.activePartnerName = '';
this.partners = [];
this.possiblePartnersData = {};
this.possiblePartners = [];
this.matchedPartners = [];
this.activeMessages = {};
this.messages = [];
this.list = [];
this.frequentlyUpdateTime;
this.newMessageOption = false;
this.selectedTextLength = 0;

this.on('mount', function () {
    this.handleUser();
    this.handleConversations();
    this.frequentlyUpdateTime = setInterval(this.handleTime, 60 * 1000);
});
this.on('unmount', function () {
    clearInterval(this.frequentlyUpdateTime);
});

this.on('updated', function () {
    document.querySelector('.sidebar .active') || this.refs.partners.firstElementChild.click();
    this.refs.messages.scrollTop = this.refs.messages.scrollHeight;
});
});
    
  if (false) {
    module.hot.accept()
    if (module.hot.data) {
      riot.reload('graphjs-messages')
    }
  }
  

/***/ }),
/* 111 */
/***/ (function(module, exports, __webpack_require__) {


    var riot = __webpack_require__(0)
    riot.tag2('graphjs-profile', '<graphjs-profile-header id="{opts.id}" active="{this.active}" minor="{true}" callback="{changeProperties}"></graphjs-profile-header> <graphjs-profile-activity minor="{true}" callback="{changeProperties}" if="{this.active == \'activity\'}"></graphjs-profile-activity> <graphjs-profile-followers id="{opts.id}" minor="{true}" callback="{changeProperties}" if="{this.active == \'followers\'}"></graphjs-profile-followers> <graphjs-profile-following id="{opts.id}" minor="{true}" callback="{changeProperties}" if="{this.active == \'following\'}"></graphjs-profile-following> <graphjs-profile-groups id="{opts.id}" minor="{true}" callback="{changeProperties}" if="{this.active == \'groups\'}"></graphjs-profile-groups> <graphjs-profile-settings id="{opts.id}" minor="{true}" callback="{changeProperties}" if="{this.active == \'settings\'}"></graphjs-profile-settings>', 'graphjs-profile{display:block;width:48em;margin:0 auto}', '', function(opts) {
'use strict';

var _this = this;

__webpack_require__(57);

__webpack_require__(58);

__webpack_require__(59);

__webpack_require__(61);

__webpack_require__(63);

__webpack_require__(64);

this.active = opts.default || 'followers';
this.changeProperties = function (event) {
    _this.active = event.currentTarget.dataset.link;
    _this.update();
};
});
    
  if (false) {
    module.hot.accept()
    if (module.hot.data) {
      riot.reload('graphjs-profile')
    }
  }
  

/***/ }),
/* 112 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


Object.defineProperty(exports, "__esModule", {
	value: true
});

exports.default = function () {
	var args = Array.from(arguments);
	var callback = args.pop();
	listMembershipsCall(args, callback);
};

var _api = __webpack_require__(1);

var _api2 = _interopRequireDefault(_api);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function listMembershipsCall(args, callback) {
	(0, _api2.default)("listMemberships", {
		"id": args[0]
	}, function (response) {
		callback(response.data);
	});
};

;

/***/ }),
/* 113 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";
var __WEBPACK_AMD_DEFINE_FACTORY__, __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;

var _typeof = typeof Symbol === "function" && typeof Symbol.iterator === "symbol" ? function (obj) { return typeof obj; } : function (obj) { return obj && typeof Symbol === "function" && obj.constructor === Symbol && obj !== Symbol.prototype ? "symbol" : typeof obj; };

!function (e) {
  "use strict";
   true ? !(__WEBPACK_AMD_DEFINE_ARRAY__ = [], __WEBPACK_AMD_DEFINE_FACTORY__ = (e),
				__WEBPACK_AMD_DEFINE_RESULT__ = (typeof __WEBPACK_AMD_DEFINE_FACTORY__ === 'function' ?
				(__WEBPACK_AMD_DEFINE_FACTORY__.apply(exports, __WEBPACK_AMD_DEFINE_ARRAY__)) : __WEBPACK_AMD_DEFINE_FACTORY__),
				__WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__)) : e();
}(function () {
  "use strict";
  var e,
      t,
      i,
      n = 0,
      o = "149",
      a = window.location.search.indexOf("debug=true") > -1,
      d = window.location.search.indexOf("dev=true") > -1;window.jQuery ? i = window.jQuery : window.$ && window.$.fn && window.$.fn.jquery && (i = window.$);var r = function r(e) {
    if (null == e || "object" != (typeof e === "undefined" ? "undefined" : _typeof(e)) || e.tagName) return e;var t = e.constructor();for (var i in e) {
      t[i] = r(e[i]);
    }return t;
  },
      l = function l(e, t) {
    return t = r(t), t.kind = e, JSON.stringify(t);
  },
      c = function c(e) {
    return JSON.parse(e);
  },
      u = function u() {
    try {
      var e = document.createElement("style");e.type = "text/css", e.innerHTML = ".cloudinary-thumbnails { list-style: none; margin: 10px 0; padding: 0 } .cloudinary-thumbnails:after { clear: both; display: block; content: '' } .cloudinary-thumbnail { float: left; padding: 0; margin: 0 15px 5px 0; display: none } .cloudinary-thumbnail.active { display: block } .cloudinary-thumbnail img { border: 1px solid #01304d; border-radius: 2px; -moz-border-radius: 2px; -webkit-border-radius: 2px } .cloudinary-thumbnail span { font-size: 11px; font-family: Arial, sans-serif; line-height: 14px; border: 1px solid #aaa; max-width: 150px; word-wrap: break-word; word-break: break-all; display: inline-block; padding: 3px; max-height: 60px; overflow: hidden; color: #999; } .cloudinary-delete { vertical-align: top; font-size: 13px; text-decoration: none; padding-left: 2px; line-height: 8px; font-family: Arial, sans-serif; color: #01304d }.cloudinary-button { color: #fefeff; text-decoration: none; font-size: 18px; line-height: 28px; height: 28x; border-radius: 6px; -moz-border-radius: 6px; -webkit-border-radius: 6px; font-weight: normal; text-decoration: none;   display: inline-block; padding: 4px 30px 4px 30px; background: #0284cf; font-family: Helvetica, Arial, sans-serif;   background: url(data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiA/Pgo8c3ZnIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgd2lkdGg9IjEwMCUiIGhlaWdodD0iMTAwJSIgdmlld0JveD0iMCAwIDEgMSIgcHJlc2VydmVBc3BlY3RSYXRpbz0ibm9uZSI+CiAgPGxpbmVhckdyYWRpZW50IGlkPSJncmFkLXVjZ2ctZ2VuZXJhdGVkIiBncmFkaWVudFVuaXRzPSJ1c2VyU3BhY2VPblVzZSIgeDE9IjAlIiB5MT0iMCUiIHgyPSIwJSIgeTI9IjEwMCUiPgogICAgPHN0b3Agb2Zmc2V0PSIwJSIgc3RvcC1jb2xvcj0iIzAyODRjZiIgc3RvcC1vcGFjaXR5PSIxIi8+CiAgICA8c3RvcCBvZmZzZXQ9IjEwMCUiIHN0b3AtY29sb3I9IiMwMjU5OGIiIHN0b3Atb3BhY2l0eT0iMSIvPgogIDwvbGluZWFyR3JhZGllbnQ+CiAgPHJlY3QgeD0iMCIgeT0iMCIgd2lkdGg9IjEiIGhlaWdodD0iMSIgZmlsbD0idXJsKCNncmFkLXVjZ2ctZ2VuZXJhdGVkKSIgLz4KPC9zdmc+);   background: -moz-linear-gradient(top,  #0284cf 0%, #02598b 100%);   background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,#0284cf), color-stop(100%,#02598b));   background: -webkit-linear-gradient(top,  #0284cf 0%,#02598b 100%);   background: -o-linear-gradient(top,  #0284cf 0%,#02598b 100%);   background: -ms-linear-gradient(top,  #0284cf 0%,#02598b 100%);   background: linear-gradient(to bottom,  #0284cf 0%,#02598b 100%);   filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#0284cf', endColorstr='#02598b',GradientType=0 ); }.cloudinary-button:hover { background: #02598b;   background: url(data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiA/Pgo8c3ZnIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgd2lkdGg9IjEwMCUiIGhlaWdodD0iMTAwJSIgdmlld0JveD0iMCAwIDEgMSIgcHJlc2VydmVBc3BlY3RSYXRpbz0ibm9uZSI+CiAgPGxpbmVhckdyYWRpZW50IGlkPSJncmFkLXVjZ2ctZ2VuZXJhdGVkIiBncmFkaWVudFVuaXRzPSJ1c2VyU3BhY2VPblVzZSIgeDE9IjAlIiB5MT0iMCUiIHgyPSIwJSIgeTI9IjEwMCUiPgogICAgPHN0b3Agb2Zmc2V0PSIwJSIgc3RvcC1jb2xvcj0iIzAyNTk4YiIgc3RvcC1vcGFjaXR5PSIxIi8+CiAgICA8c3RvcCBvZmZzZXQ9IjEwMCUiIHN0b3AtY29sb3I9IiMwMjg0Y2YiIHN0b3Atb3BhY2l0eT0iMSIvPgogIDwvbGluZWFyR3JhZGllbnQ+CiAgPHJlY3QgeD0iMCIgeT0iMCIgd2lkdGg9IjEiIGhlaWdodD0iMSIgZmlsbD0idXJsKCNncmFkLXVjZ2ctZ2VuZXJhdGVkKSIgLz4KPC9zdmc+);   background: -moz-linear-gradient(top,  #02598b 0%, #0284cf 100%);   background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,#02598b), color-stop(100%,#0284cf));   background: -webkit-linear-gradient(top,  #02598b 0%,#0284cf 100%);   background: -o-linear-gradient(top,  #02598b 0%,#0284cf 100%);   background: -ms-linear-gradient(top,  #02598b 0%,#0284cf 100%);   background: linear-gradient(to bottom,  #02598b 0%,#0284cf 100%);   filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#02598b', endColorstr='#0284cf',GradientType=0 ); ";var t = document.getElementsByTagName("head")[0];t && t.appendChild(e);
    } catch (e) {
      console && console.log && console.log("Cannot initialize stylesheet: " + e);
    }
  };u();var s = function s(u, _s) {
    var g,
        p,
        f,
        b = n++,
        m = r(u),
        y = m.element,
        w = !!m.inline_container,
        h = !1,
        I = !1;delete m.element, m.widget_id = b;var v = function v() {
      m.cloud_name || (m.cloud_name = e), !m.api_key && t && (m.api_key = t), m.secure = m.secure || "https:" === document.location.protocol, m.requireSignature = !!m.upload_signature;(function () {
        for (var e = !!m.upload_signature, t = e ? ["api_key", "cloud_name"] : ["cloud_name", "upload_preset"], i = 0; i < t.length; i++) {
          if (!m[t[i]]) throw "Missing required option: " + t[i];
        }
      })();g = window.document.createElement("iframe");var i = m.secure ? "https:" : "http:",
          n = [];a && n.push("debug=true"), d && n.push("dev=true"), w && n.push("inline=true"), m.cloud_name && n.push("cloud_name=" + m.cloud_name), f = m.widgetHost || i + "//widget.cloudinary.com/n/" + m.cloud_name + "/" + o + "/index.html", g.setAttribute("src", f + "?" + n.join("&")), g.setAttribute("width", "100%"), g.setAttribute("height", "100%"), g.setAttribute("frameborder", "no"), g.setAttribute("allow", "camera"), g.style.display = "none", g.style.width = "100%", g.style.border = "none", w ? g.style.height = "520px" : (g.style.position = "fixed", g.style.top = "0px", g.style.left = "0px", g.style.height = "100%", g.style.background = "transparent", g.style.zIndex = "1000000"), x(g, "load", function () {
        A("init", m), I = !0, h && (g.style.display = "block", g.focus(), A("open", {}));
      }), x(window, "message", _);var r = function r() {
        if (!w) return document.body;if ("string" == typeof m.inline_container) {
          var e = document.querySelector(m.inline_container);if (e) return e;throw "Element Not Found (" + m.inline_container + ")";
        }return m.inline_container;
      },
          l = r();l.appendChild(g), w || x(window.document, "keyup", function (e) {
        27 == e.keyCode && S();
      }), y && k();
    },
        k = function k() {
      y.style.display = "none";var e = window.document.createElement("a");e.setAttribute("class", m.button_class || "cloudinary-button"), e.setAttribute("href", "#"), e.innerHTML = m.button_caption || "Upload image", y.parentNode.insertBefore(e, y.previousSibling), x(e, "click", function (e) {
        return C(), e && e.preventDefault && e.preventDefault(), e && e.stopPropagation && e.stopPropagation(), !1;
      }), !m.field_name && y.getAttribute("name") && "" != y.getAttribute("name") && (m.field_name = y.getAttribute("name"));
    },
        x = function x(e, t, i) {
      e.addEventListener ? e.addEventListener(t, i, !1) : e.attachEvent("on" + t, i);
    },
        C = function C(e) {
      h = !0, p = window.document.body.style.overflow, w || (window.document.body.style.overflow = "hidden"), I && (g.style.display = "block", g.focus(), A("open", e || {}));
    },
        _ = function _(e) {
      if (e.origin.match(/cloudinary\.com/)) {
        var t;try {
          t = c(e.data);
        } catch (e) {
          return;
        }if (t.widget_id == b) switch (t.kind) {case "fileuploadsuccess":
            i && i(y || m.form || document).trigger("cloudinarywidgetfileuploadsuccess", [t.result]);break;case "success":
            m.keep_widget_open || w || S(), M(t.result), _s && _s(null, t.result), i && i(y || m.form || document).trigger("cloudinarywidgetsuccess", [t.result]);break;case "fileuploadfail":
            w && _s && _s(t), i && i(y || m.form || document).trigger("cloudinarywidgetfileuploadfail", [t.result]);break;case "error":
            m.keep_widget_open || w || S(), _s && _s(t), i && i(y || m.form || document).trigger("cloudinarywidgeterror", t);break;case "closed":
            S();var n = { message: "User closed widget" };_s && _s(n), i && i(y || m.form || document).trigger("cloudinarywidgetclosed", n);break;case "get-signature":
            var o = m.upload_signature;if ("string" == typeof o) A("signature", { signature: o });else if ("function" == typeof o) {
              var a = r(t);delete a.widget_id, delete a.kind, delete a.file, o(function (e) {
                A("signature", { signature: e });
              }, a);
            }}
      }
    },
        A = function A(e, t) {
      g.contentWindow.postMessage(l(e, t), f);
    },
        S = function S() {
      g.style.display = "none", window.document.body.style.overflow = p, h = !1;
    },
        M = function M(e) {
      if (i) {
        var t = m.form;!t && t !== !1 && y && (t = i(y).closest("form"));var n = m.field_name || "image";if (t && t.length && (i(t).find('input[name="' + n + '"]').remove(), i.each(e, function (e, o) {
          var a = [o.resource_type, o.type, o.path].join("/") + "#" + o.signature;i("<input />").addClass("cloudinary-hidden-field").attr({ type: "hidden", name: n, "data-cloudinary-public-id": o.public_id }).val(a).data("cloudinary", o).appendTo(t);
        })), m.thumbnails !== !1 && (m.thumbnails || y)) {
          var o = i("<ul></ul>").addClass("cloudinary-thumbnails");i.each(e, function (e, t) {
            var n = i("<li></li>").addClass("cloudinary-thumbnail").data("cloudinary", t);t.thumbnail_url ? n.append(i("<img />").attr("src", t.thumbnail_url)) : n.append(i("<span></span>").text(t.public_id)), t.delete_token && n.append(i("<a></a>").addClass("cloudinary-delete").attr("href", "#").text("×")), n.find("img").on("load", function () {
              n.addClass("active");
            }), o.append(n);
          }), o.find("li").length > 0 && (m.thumbnails ? i(m.thumbnails).append(o) : i(y).after(o)), o.find(".cloudinary-delete").click(function (e) {
            e.preventDefault();var o = i(this).parents(".cloudinary-thumbnail").data("cloudinary"),
                a = Z(o.delete_token);if (a && a.always(function (e) {
              200 == e.status && i(y || m.form || document).trigger("cloudinarywidgetdeleted", o);
            }), i(this).parents(".cloudinary-thumbnail").hide("slow"), t) {
              var d = i(t).find('input[name="' + n + '"][data-cloudinary-public-id="' + o.public_id + '"].cloudinary-hidden-field');i(t).find('input[name="' + n + '"].cloudinary-hidden-field').length > 1 ? i(d).remove() : i(d).attr("data-cloudinary-public-id", "").val("").data("cloudinary", null);
            }
          });
        }
      }
    },
        Z = function Z(e, t) {
      if (i) {
        t = t || {};var n = t.url;n || (n = "https://api.cloudinary.com/v1_1/" + m.cloud_name + "/delete_by_token");var o = i.support.xhrFileUpload ? "json" : "iframe json";return i.ajax({ url: n, method: "POST", data: { token: e }, headers: { "X-Requested-With": "XMLHttpRequest" }, dataType: o });
      }
    };return v(), { open: function open(e) {
        return C(e), this;
      }, close: S };
  };window.cloudinary = window.cloudinary || {}, window.cloudinary.openUploadWidget = function (e, t) {
    return s(e, t).open();
  }, window.cloudinary.createUploadWidget = function (e, t) {
    return s(e, t);
  }, window.cloudinary.applyUploadWidget = function (e, t, i) {
    var n = r(t);return n.element = e, s(n, i);
  }, window.cloudinary.setCloudName = function (t) {
    e = t;
  }, window.cloudinary.setAPIKey = function (e) {
    t = e;
  }, i && (i.fn.cloudinary_upload_widget = function (e, t) {
    window.cloudinary.applyUploadWidget(i(this)[0], e, t);
  });
});

/***/ }),
/* 114 */
/***/ (function(module, exports, __webpack_require__) {


    var riot = __webpack_require__(0)
    riot.tag2('graphjs-profile-card', '<a onclick="{handleFollow}" class="left option" if="{profile && userId && userId != id}"> <svg viewbox="0 0 24 20" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"> <g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd"> <g transform="translate(-22.000000, -20.000000)" fill="black" fill-rule="nonzero"> <path d="M22,39.0597068 L22,37.9313549 C22,36.9492708 22.4486148,36.0089776 23.2390314,35.4239063 C25.5461933,33.6686922 27.8960803,32.4985495 28.3874204,32.2687001 C28.4515082,32.2478047 28.4942334,32.1851185 28.4942334,32.1224322 L28.4942334,30.7224401 C28.1310691,30.1164733 27.917443,29.426925 27.8319925,28.8209582 C27.6183664,28.8000628 27.3192899,28.5075271 27.0202133,27.4418615 C26.5929611,25.9791831 27.0415759,25.7702291 27.4261029,25.7911245 C27.148389,25.0179945 27.148389,24.2657599 27.3192899,23.5762115 C27.5115534,22.7612907 27.9601682,22.0926377 28.4728708,21.591148 C28.79331,21.2568215 29.1564743,20.9642859 29.5410013,20.713541 C29.8614405,20.5045869 30.2032422,20.3165283 30.5877692,20.1911559 C30.8868457,20.0866788 31.2072849,20.0239926 31.527724,20.0239926 C32.5744919,19.9195156 33.3649085,20.1702605 33.9203363,20.5045869 C34.7534781,20.9642859 35.0739173,21.5493572 35.0739173,21.5493572 C35.0739173,21.5493572 37.1888157,21.695625 36.2702234,26.0209739 C36.5479374,26.1254509 36.7615635,26.5015682 36.4197617,27.6299201 C36.0138721,29.0299123 35.6507078,29.1134939 35.415719,28.9672261 C35.3302686,29.4478204 35.1807303,29.9911009 34.924379,30.4925906 C34.924379,31.2030344 34.924379,31.850792 34.924379,32.1015368 C34.924379,32.164223 34.9671042,32.2269093 35.0311921,32.2478047 C35.5438947,32.4985495 37.8937818,33.6686922 40.2009437,35.4239063 C40.9913602,36.029873 41.439975,36.9492708 41.439975,37.9313549 L41.439975,39.0597068 C41.439975,39.5820919 41.0127228,40 40.4786576,40 L22.9399548,40 C22.4272522,39.9791046 22,39.5611965 22,39.0597068 Z M37.7770946,28.6529954 L39.0022126,28.6665402 L40.0181642,28.6777726 L39.993387,26.4367029 C39.9857886,25.7494416 40.5176988,25.2175314 41.2049602,25.2251298 C41.8922215,25.2327281 42.4360248,25.7765314 42.4436231,26.4637927 L42.4684003,28.7048623 L44.70947,28.7296396 C45.3967313,28.7372379 45.9405346,29.2810412 45.9481329,29.9683025 C45.9557313,30.6555639 45.4238211,31.187474 44.7365597,31.1798757 L42.4954901,31.1550985 L42.5067224,32.17105 L42.5202673,33.3961681 C42.5278657,34.0834295 41.9959555,34.6153396 41.3086941,34.6077413 C40.6214328,34.6001429 40.0776295,34.0563397 40.0700312,33.3690783 L40.0564863,32.1439603 L40.045254,31.1280087 L39.0293024,31.1167764 L37.8041843,31.1032315 C37.116923,31.0956331 36.5731197,30.5518299 36.5655214,29.8645685 C36.557923,29.1773072 37.0898332,28.645397 37.7770946,28.6529954 Z"></path> </g> </g> </svg> </a> <a class="right option" onclick="{handleMessagesBox}" if="{profile && userId && userId != id}"> <svg viewbox="0 0 50 48" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"> <g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd"> <path d="M34.8236776,11.6342064 L4.78589421,11.6342064 C2.14105793,11.6342064 0,13.7752644 0,16.4201006 L0,36.0044835 C0,38.6493198 2.14105793,40.7903777 4.78589421,40.7903777 L19.5843829,40.7903777 L31.3602015,47.7803022 L30.7934509,40.7903777 L34.8866499,40.7903777 C37.5314861,40.7903777 39.6725441,38.6493198 39.6725441,36.0044835 L39.6725441,16.4201006 C39.6725441,13.7752644 37.4685139,11.6342064 34.8236776,11.6342064 Z M10.5478586,29.1405026 C9.22544054,29.1405026 8.12342545,28.0384875 8.12342545,26.7160694 C8.12342545,25.3936513 9.22544054,24.2916362 10.5478586,24.2916362 C11.8702767,24.2916362 12.9722918,25.3936513 12.9722918,26.7160694 C12.9722918,28.0384875 11.8702767,29.1405026 10.5478586,29.1405026 Z M19.8677586,29.1405026 C18.5453405,29.1405026 17.4433254,28.0384875 17.4433254,26.7160694 C17.4433254,25.3936513 18.5453405,24.2916362 19.8677586,24.2916362 C21.1901767,24.2916362 22.2921918,25.3936513 22.2921918,26.7160694 C22.2187241,28.0384875 21.1901767,29.1405026 19.8677586,29.1405026 Z M29.124686,29.1405026 C27.8022679,29.1405026 26.7002529,28.0384875 26.7002529,26.7160694 C26.7002529,25.3936513 27.8022679,24.2916362 29.124686,24.2916362 C30.4471041,24.2916362 31.5491192,25.3936513 31.5491192,26.7160694 C31.5491192,28.0384875 30.4471041,29.1405026 29.124686,29.1405026 Z M45.2141058,0.779999733 C47.8589421,0.779999733 50,2.9210577 50,5.56589402 L50,25.0873049 C50,27.7321412 47.8589421,29.8731992 45.2141058,29.8731992 L42.3803526,29.8731992 L42.4433249,16.523073 C42.4433249,12.3039294 39.0428212,8.90342556 34.8236776,8.90342556 L10.3904282,8.90342556 L10.3904282,5.56589402 C10.3904282,2.9210577 12.5314861,0.779999733 15.1763224,0.779999733 L45.2141058,0.779999733 Z"></path> </g> </svg> </a> <div class="information" if="{profile}"> <img riot-src="{profile.avatar || \'lib/images/avatars/user.png\'}"> <a>{profile.fullName || profile.username}</a> <p>{profile.about}</p> </div> <div class="information" if="{!profile}"> <img src="lib/images/avatars/user.png"> <a>User doesn\'t exist.</a> <p>We couldn\'t find any user matching this id.</p> </div> <button data-link="profile" data-id="{id}" onclick="{handleShow}" if="{profile}">View Profile</button> <button if="{!profile}" onclick="{handleUpdate}">Refresh</button>', 'graphjs-profile-card{display:block;color:rgba(63,95,127,0.65)} graphjs-profile-card .option{display:inline-block;width:3.75em;height:3.75em;padding:1em;text-align:center} graphjs-profile-card .option svg path{fill:#007fff} graphjs-profile-card .option:hover svg path{fill:#198cff} graphjs-profile-card .option:active svg path{fill:#0072e6} graphjs-profile-card .option.left{float:left} graphjs-profile-card .option.right{float:right} graphjs-profile-card .option svg{position:relative;max-width:1.5em;max-height:auto;vertical-align:middle} graphjs-profile-card .option svg path{fill:#007fff;-webkit-transition:fill .35s ease;-moz-transition:fill .35s ease;-ms-transition:fill .35s ease;-o-transition:fill .35s ease} graphjs-profile-card .information{padding-top:2em} graphjs-profile-card .information img{width:6.5em;height:6.5em;border:4px solid rgba(63,95,127,0.15);-webkit-border-radius:50%;-moz-border-radius:50%;border-radius:50%;-moz-background-clip:padding;-webkit-background-clip:padding-box;background-clip:padding-box} graphjs-profile-card .information a{display:inline-block;overflow:hidden;width:90%;max-height:2.5em;margin:0 5%;margin-top:.5em;font-size:1.2em;line-height:1.25em;font-family:"Rubik";font-weight:800;color:#007fff} graphjs-profile-card .information a:hover{color:#198cff} graphjs-profile-card .information a:active{color:#0072e6} graphjs-profile-card .information p{display:inline-block;overflow:hidden;width:90%;max-height:2.5em;margin:0 5%;margin-top:.75em;color:#6f879f;font-size:.95em;line-height:1.25em} graphjs-profile-card.color .option svg path{fill:white} graphjs-profile-card.color .information img{border:4px solid white}', 'class="card box"', function(opts) {
'use strict';

var _this = this;

var _getProfile = __webpack_require__(7);

var _getProfile2 = _interopRequireDefault(_getProfile);

var _showProfile = __webpack_require__(72);

var _showProfile2 = _interopRequireDefault(_showProfile);

var _follow = __webpack_require__(73);

var _follow2 = _interopRequireDefault(_follow);

var _showMessages = __webpack_require__(11);

var _showMessages2 = _interopRequireDefault(_showMessages);

var _getUser = __webpack_require__(6);

var _getUser2 = _interopRequireDefault(_getUser);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

this.id = opts.id;
this.following = false;
this.userId = undefined;

this.on('before-mount', function () {
    this.handleInformation(this.id);
    this.handleUser();
});
this.on('mount', function () {
    opts.theme && this.root.classList.add(opts.theme);
});

this.handleInformation = function (id) {
    var self = _this;
    (0, _getProfile2.default)(id, function (response) {
        if (response.success) {
            self.profile = response.profile;
            self.update();
        } else {
            //Handle errors
        }
    });
};
this.handleUser = function () {
    var self = _this;
    (0, _getUser2.default)(function (response) {
        if (response.success) {
            self.userId = response.id;
            self.update();
        } else {
            //Handle errors
        }
    });
};
this.handleShow = function (event) {
    var self = _this;
    var dataset = event.target.dataset;
    switch (dataset.link) {
        case 'profile':
            (0, _showProfile2.default)({
                id: dataset.id,
                scroll: true
            });
            break;
    }
};
this.handleFollow = function () {
    var self = _this;
    (0, _follow2.default)(self.id, function (response) {
        if (response.success) {
            self.following = true;
            self.update();
        } else {
            //Handle errors
        }
    });
};
this.handleMessagesBox = function () {
    return (0, _showMessages2.default)();
};
this.handleUpdate = function () {
    return _this.update();
};
});
    
  if (false) {
    module.hot.accept()
    if (module.hot.data) {
      riot.reload('graphjs-profile-card')
    }
  }
  

/***/ }),
/* 115 */
/***/ (function(module, exports, __webpack_require__) {


    var riot = __webpack_require__(0)
    riot.tag2('graphjs-state', '<div class="not-logged" if="{!id}"> <a onclick="{handleLoginBox}">Login</a> <a onclick="{handleRegisterBox}">Register</a> </div> <div class="logged" if="{id}"> <a class="details" if="{profile}"> <img riot-src="{profile.avatar || \'lib/images/avatars/user.png\'}"> <span>{profile.fullname || profile.username}</span> </a> <a class="exit" onclick="{handleExit}"> <svg viewbox="0 0 20 18" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"> <g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd"> <g transform="translate(-17.000000, -16.000000)" fill="black" fill-rule="nonzero"> <path d="M19.9086651,31.0702576 L25.9789227,31.0702576 L25.9789227,34 L17,34 L17,16 L26,16 L26,18.9297424 L19.9086651,18.9297424 L19.9086651,31.0702576 Z M29.3157895,21.0187266 L31.4210526,23.0580524 L23,23.0580524 L23,25.9213483 L31.4210526,25.9213483 L29.3157895,27.9812734 L31.3789474,30 L37,24.5 L31.3789474,19 L29.3157895,21.0187266 Z"></path> </g> </g> </svg> </a> </div>', 'graphjs-state{display:inline-block;box-sizing:content-box !important;height:50px;color:rgba(63,95,127,0.65);font-size:1.2em;font-family:"Rubik";font-weight:700;border:none;background-color:white} graphjs-state a{float:left;border-right:1px dotted rgba(63,95,127,0.2);background-color:transparent} graphjs-state a:last-of-type{border-right:none !important} graphjs-state a:hover{background-color:rgba(0,0,0,0.05)} graphjs-state a:last-of-type{border-right-color:transparent} graphjs-state .not-logged{height:50px;line-height:50px;text-align:center} graphjs-state .not-logged a{display:inline-block;padding:0 15px;line-height:50px} graphjs-state .logged{height:50px} graphjs-state .logged a{display:inline-block;color:#007fff;line-height:50px;-webkit-transition:background-color .35s ease;-moz-transition:background-color .35s ease;-ms-transition:background-color .35s ease;-o-transition:background-color .35s ease} graphjs-state .logged .details{float:left;height:50px;padding:5px} graphjs-state .logged .details>*{float:left} graphjs-state .logged .details img{width:calc(50px - 10px);height:calc(50px - 10px);-webkit-border-radius:6px;-moz-border-radius:6px;border-radius:6px;-moz-background-clip:padding;-webkit-background-clip:padding-box;background-clip:padding-box} graphjs-state .logged .details span{height:100%;max-width:150px;margin-left:5px;padding:0 10px;line-height:calc(50px - 10px);overflow:hidden;text-overflow:ellipsis;white-space:nowrap;vertical-align:middle} graphjs-state .logged .exit{float:right;width:50px;height:50px;text-align:center} graphjs-state .logged .exit svg{position:relative;width:auto;height:18px;margin:16px 0} graphjs-state .logged .exit svg path{fill:#9fafbf;-webkit-transition:fill .35s ease;-moz-transition:fill .35s ease;-ms-transition:fill .35s ease;-o-transition:fill .35s ease} graphjs-state.color{background-color:#007fff} graphjs-state.color a{color:white;border-right:1px dotted rgba(255,255,255,0.35)} graphjs-state.color a:last-of-type{border-right:none} graphjs-state.color a:hover{background-color:rgba(0,0,0,0.05)} graphjs-state.color .logged .exit svg path{fill:rgba(255,255,255,0.5)}', 'class="{!opts.flat && \'box\'}"', function(opts) {
'use strict';

var _this = this;

var _getUser = __webpack_require__(6);

var _getUser2 = _interopRequireDefault(_getUser);

var _getProfile = __webpack_require__(7);

var _getProfile2 = _interopRequireDefault(_getProfile);

var _logout = __webpack_require__(74);

var _logout2 = _interopRequireDefault(_logout);

var _showLogin = __webpack_require__(10);

var _showLogin2 = _interopRequireDefault(_showLogin);

var _showRegister = __webpack_require__(8);

var _showRegister2 = _interopRequireDefault(_showRegister);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

this.on('before-mount', function () {
    this.handleState();
});
this.on('mount', function () {
    opts.theme && this.root.classList.add(opts.theme);
});

this.handleLoginBox = function () {
    return (0, _showLogin2.default)();
};
this.handleRegisterBox = function () {
    return (0, _showRegister2.default)();
};
this.handleState = function () {
    var self = _this;
    (0, _getUser2.default)(function (response) {
        if (response.success) {
            self.id = response.id;
            self.handleInformation(self.id);
        } else {
            //Handle errors
        }
    });
};
this.handleInformation = function (id) {
    var self = _this;
    (0, _getProfile2.default)(id, function (response) {
        if (response.success) {
            self.profile = response.profile;
            self.update();
        } else {
            //Handle errors
        }
    });
};
this.handleExit = function () {
    var self = _this;
    (0, _logout2.default)(function (response) {
        if (response.success) {
            self.id = undefined;
            self.update();
        } else {
            //Handle errors
        }
    });
};
});
    
  if (false) {
    module.hot.accept()
    if (module.hot.data) {
      riot.reload('graphjs-state')
    }
  }
  

/***/ }),
/* 116 */
/***/ (function(module, exports, __webpack_require__) {


    var riot = __webpack_require__(0)
    riot.tag2('docs-index', '<aside> <docs-menu callback="{changeProperties}" items="{items}"></docs-menu> </aside> <main ref="main"> </main>', 'docs-index{display:inline-block;width:100%} docs-index aside{overflow-y:scroll;position:fixed;top:0;bottom:0;left:0;width:20%;height:auto;background:linear-gradient(#5d3cf6, #9e77ff)} docs-index aside .menu{color:white;display:inline-block;padding:10%} docs-index aside .menu img{width:85%;height:auto;margin:7.5%} docs-index aside .menu form fieldset{border:none} docs-index aside .menu form fieldset input[type="radio"]{display:inline-block;width:auto;margin-left:10%} docs-index aside .menu form fieldset input[type="radio"]:first-of-type{margin-left:0} docs-index aside .menu h2{color:white;display:inline-block;width:100%;margin:1em 0;padding:0 5%} docs-index aside .menu a{color:white;display:inline-block;width:100%;padding:5%} docs-index aside .menu a.active{color:yellow} docs-index main{display:inline-block;width:70%;margin:2.5% 5% 2.5% 25%} docs-index main h1{color:#5d3cf6;margin:1em 0} docs-index main h2{color:#9e77ff;margin:2em 0} docs-index main .demo{width:100%;margin-bottom:5%} docs-index main .options form{width:100%;margin-bottom:5%;margin-right:5%} docs-index main .options form fieldset{float:left;position:relative;width:47.5%;height:5em;margin:0;margin-bottom:2.5%;padding:0;border:none} docs-index main .options form fieldset:nth-child(even){margin-left:5%} docs-index main .options form fieldset legend{float:left;width:auto;text-align:left} docs-index main .options form fieldset input[type="checkbox"]{display:inline-block;max-width:1.5em;max-height:1.5em;margin:0} docs-index main .options form fieldset input[type="text"]{position:relative;margin:0;margin-top:.5em} docs-index main .options form fieldset .radiobutton{display:inline-block;width:100%;height:2.5em;margin-top:.5em} docs-index main .options form fieldset input[type="radio"]{display:inline-block;float:left;height:inherit;max-width:1.5em;margin:0;padding:0} docs-index main .options form fieldset input[type="radio"]+label{float:left;height:inherit;line-height:2.5em;margin-right:2.5%} docs-index main .options form .code{display:block;overflow:hidden;width:100%;font-size:1.2em;line-height:150%;word-wrap:break-word;white-space:pre-wrap} docs-index main .options form button{background-color:#9e77ff} docs-index main .options form button:hover{background-color:#a885ff} docs-index main .options form button:active{background-color:#8e6be6}', '', function(opts) {
'use strict';

var _this = this;

__webpack_require__(117);

this.activeItem = 'introduction';
this.changeProperties = function (event) {
    for (var _iterator = event.target.parentNode.children, _isArray = Array.isArray(_iterator), _i = 0, _iterator = _isArray ? _iterator : _iterator[Symbol.iterator]();;) {
        var _ref;

        if (_isArray) {
            if (_i >= _iterator.length) break;
            _ref = _iterator[_i++];
        } else {
            _i = _iterator.next();
            if (_i.done) break;
            _ref = _i.value;
        }

        var element = _ref;

        element.className == 'active' && element.classList.remove('active');
    }
    event.target.classList.add('active');
    _this.activeItem = event.target.dataset.id;
    _this.update();
    _this.refs.main.innerHTML = '';
    _this.createTag(event.target.dataset.component, event.target.dataset.label);
};
this.items = [{ "label": "Auth", "component": "auth" },
//{"label": "Auth: Register", "component": "auth-register"},
//{"label": "Auth: Login", "component": "auth-login"},
//{"label": "Auth: Reset Password", "component": "auth-reset"},
{ "label": "Star: Button", "component": "star-button" }, { "label": "Star: List", "component": "star-list" }, { "label": "Comments", "component": "comments" }, { "label": "Messages", "component": "messages" }, { "label": "Forum", "component": "forum" },
//{"label": "Forum: List", "component": "forum-list"},
//{"label": "Forum: Compose", "component": "forum-compose"},
//{"label": "Forum: Thread", "component": "forum-thread"},
{ "label": "Profile", "component": "profile" }, { "label": "Profile: Card", "component": "profile-card" }, { "label": "Group", "component": "group" }, { "label": "Group: Card", "component": "group-card" }, { "label": "State", "component": "state" }, { "label": "Alert", "component": "alert" }];
this.createTag = function (itemComponent, itemLabel) {
    var currentElement = document.createElement('docs-' + itemComponent);
    var component = document.createAttribute('component');
    component.value = 'graphjs-' + itemComponent;
    currentElement.setAttributeNode(component);
    var title = document.createAttribute('title');
    title.value = itemLabel;
    currentElement.setAttributeNode(title);
    riot.mount(currentElement);
    _this.refs.main.appendChild(currentElement);
};
});
    
  if (false) {
    module.hot.accept()
    if (module.hot.data) {
      riot.reload('docs-index')
    }
  }
  

/***/ }),
/* 117 */
/***/ (function(module, exports, __webpack_require__) {


    var riot = __webpack_require__(0)
    riot.tag2('docs-menu', '<img src="lib/docs/logo.png"> <h2>Theme</h2> <form> <fieldset name="theme"> <div class="radiobutton"> <input onclick="{updateRadio}" type="radio" name="theme" id="light" value="light" checked="{theme == \'light\'}"> <label for="light">Light</label> <input onclick="{updateRadio}" type="radio" name="theme" id="dark" value="dark" checked="{theme == \'dark\'}"> <label for="dark">Dark</label> <div> </fieldset> </form> <h2>Components</h2> <a each="{item in opts.items}" onclick="{opts.callback}" data-component="{item.component}" data-label="{item.label}">{item.label}</a>', '', 'class="menu"', function(opts) {
'use strict';

var _this = this;

this.theme = 'light';
this.updateRadio = function (event) {
    _this.theme = event.target.value;
    var className = 'graphjs-theme-' + _this.theme;
    document.body.classList.remove('graphjs-theme-light');
    document.body.classList.remove('graphjs-theme-dark');
    document.body.classList.add(className);
};
this.on('mount', function () {
    document.querySelectorAll('docs-menu a:first-of-type')[0].click();
});
});
    
  if (false) {
    module.hot.accept()
    if (module.hot.data) {
      riot.reload('docs-menu')
    }
  }
  

/***/ }),
/* 118 */
/***/ (function(module, exports, __webpack_require__) {


    var riot = __webpack_require__(0)
    riot.tag2('docs-alert', '<h1>{opts.title}</h1> <h2><{opts.component}></h2> <section class="demo" ref="liveDemo"></section> <section class="options"> <form> <fieldset name="title"> <legend>Title</legend> <input onclick="{updateTextWithCheckbox}" type="checkbox" checked="{specs.title}"> <input onkeyup="{updateTextWithCheckbox}" type="text" riot-value="{specs.title}"> </fieldset> <fieldset name="message"> <legend>Message</legend> <input onkeyup="{updateText}" type="text" riot-value="{specs.message}" placeholder="A message is required."> </fieldset> <fieldset name="customoption"> <legend>Custom Option</legend> <input onclick="{updateTextWithCheckbox}" type="checkbox" checked="{specs.customoption}"> <input onkeyup="{updateTextWithCheckbox}" type="text" riot-value="{specs.customoption}" placeholder="Done"> </fieldset> <fieldset name="negativeoption"> <legend>Negative Option</legend> <input onclick="{updateTextWithCheckbox}" type="checkbox" checked="{specs.negativeoption}"> <input onkeyup="{updateTextWithCheckbox}" type="text" riot-value="{specs.negativeoption}"> </fieldset> <xmp ref="inputCode" class="code">{input}</xmp> <button onclick="{handleSubmit}">Apply</button> </form> </section>', '', '', function(opts) {
"use strict";

var _this = this;

var _updateCode = __webpack_require__(2);

var _updateCode2 = _interopRequireDefault(_updateCode);

var _updateTag = __webpack_require__(3);

var _updateTag2 = _interopRequireDefault(_updateTag);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

this.input = '';
this.specs = {
    "title": "Login Required",
    "message": "You need to login to view the group details.",
    "customoption": "Login",
    "negativeoption": "Cancel"
};
this.updateText = function (event) {
    var target = event.target.parentNode.name;
    _this.specs[target] = event.target.value;
    _this.handleCode();
};
this.updateTextWithCheckbox = function (event) {
    var target = event.target.parentNode.name;
    if (event.target.type == 'checkbox') {
        var sibling = event.target.parentNode.children[2];
        event.target.checked ? _this.specs[target] = sibling.value : delete _this.specs[target];
    } else {
        var _sibling = event.target.parentNode.children[1];
        _this.specs[target] = event.target.value;
    }
    _this.handleCode();
};

this.handleCode = function () {
    (0, _updateCode2.default)(opts.component, _this.specs, _this.refs.inputCode);
};
this.handleSubmit = function (event) {
    event.preventDefault();
    (0, _updateTag2.default)(opts.component, _this.specs, _this.refs.liveDemo);
};
this.on('mount', function () {
    (0, _updateCode2.default)(opts.component, this.specs, this.refs.inputCode);
    (0, _updateTag2.default)(opts.component, this.specs, this.refs.liveDemo);
});
});

    
  if (false) {
    module.hot.accept()
    if (module.hot.data) {
      riot.reload('docs-alert')
    }
  }
  

/***/ }),
/* 119 */
/***/ (function(module, exports, __webpack_require__) {


    var riot = __webpack_require__(0)
    riot.tag2('docs-auth', '<h1>{opts.title}</h1> <h2><{opts.component}></h2> <section class="demo" ref="liveDemo"></section> <section class="options"> <form> <fieldset name="title"> <legend>Title</legend> <input onclick="{updateTextWithCheckbox}" type="checkbox" checked="{specs.title}"> <input onkeyup="{updateTextWithCheckbox}" type="text" riot-value="{specs.title}"> </fieldset> <fieldset name="default"> <legend>Default</legend> <div class="radiobutton"> <input onclick="{updateRadio}" type="radio" name="default" id="register" checked="{specs.default == \'register\'}"> <label for="register">Register</label> <input onclick="{updateRadio}" type="radio" name="default" id="login" checked="{specs.default == \'login\'}"> <label for="login">Login</label> <input onclick="{updateRadio}" type="radio" name="default" id="reset" checked="{specs.default == \'reset\'}"> <label for="reset">Reset</label> <div> </fieldset> <xmp ref="inputCode" class="code">{input}</xmp> <button onclick="{handleSubmit}">Apply</button> </form> </section>', '', '', function(opts) {
"use strict";

var _this = this;

var _updateCode = __webpack_require__(2);

var _updateCode2 = _interopRequireDefault(_updateCode);

var _updateTag = __webpack_require__(3);

var _updateTag2 = _interopRequireDefault(_updateTag);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

this.input = '';
this.specs = {
    "default": "register"
};
this.updateTextWithCheckbox = function (event) {
    var target = event.target.parentNode.name;
    if (event.target.type == 'checkbox') {
        var sibling = event.target.parentNode.children[2];
        event.target.checked ? _this.specs[target] = sibling.value : delete _this.specs[target];
    } else {
        var _sibling = event.target.parentNode.children[1];
        _this.specs[target] = event.target.value;
    }
    _this.handleCode();
};
this.updateRadio = function (event) {
    var target = event.target.parentNode.parentNode.name;
    _this.specs[target] = event.target.id;
    _this.handleCode();
};

this.handleCode = function () {
    (0, _updateCode2.default)(opts.component, _this.specs, _this.refs.inputCode);
};
this.handleSubmit = function (event) {
    event.preventDefault();
    (0, _updateTag2.default)(opts.component, _this.specs, _this.refs.liveDemo);
};
this.on('mount', function () {
    (0, _updateCode2.default)(opts.component, this.specs, this.refs.inputCode);
    (0, _updateTag2.default)(opts.component, this.specs, this.refs.liveDemo);
});
});
    
  if (false) {
    module.hot.accept()
    if (module.hot.data) {
      riot.reload('docs-auth')
    }
  }
  

/***/ }),
/* 120 */
/***/ (function(module, exports, __webpack_require__) {


    var riot = __webpack_require__(0)
    riot.tag2('docs-auth-login', '<h1>{opts.title}</h1> <h2><{opts.component}></h2> <section class="demo" ref="liveDemo"></section> <section class="options"> <form> <fieldset name="title"> <legend>Title</legend> <input onclick="{updateTextWithCheckbox}" type="checkbox" checked="{specs.title}"> <input onkeyup="{updateTextWithCheckbox}" type="text" riot-value="{specs.title}"> </fieldset> <xmp ref="inputCode" class="code">{input}</xmp> <button onclick="{handleSubmit}">Apply</button> </form> </section>', '', '', function(opts) {
'use strict';

var _this = this;

var _updateCode = __webpack_require__(2);

var _updateCode2 = _interopRequireDefault(_updateCode);

var _updateTag = __webpack_require__(3);

var _updateTag2 = _interopRequireDefault(_updateTag);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

this.input = '';
this.specs = {};
this.updateTextWithCheckbox = function (event) {
    var target = event.target.parentNode.name;
    if (event.target.type == 'checkbox') {
        var sibling = event.target.parentNode.children[2];
        event.target.checked ? _this.specs[target] = sibling.value : delete _this.specs[target];
    } else {
        var _sibling = event.target.parentNode.children[1];
        _this.specs[target] = event.target.value;
    }
    _this.handleCode();
};

this.handleCode = function () {
    (0, _updateCode2.default)(opts.component, _this.specs, _this.refs.inputCode);
};
this.handleSubmit = function (event) {
    event.preventDefault();
    (0, _updateTag2.default)(opts.component, _this.specs, _this.refs.liveDemo);
};
this.on('mount', function () {
    (0, _updateCode2.default)(opts.component, this.specs, this.refs.inputCode);
    (0, _updateTag2.default)(opts.component, this.specs, this.refs.liveDemo);
});
});
    
  if (false) {
    module.hot.accept()
    if (module.hot.data) {
      riot.reload('docs-auth-login')
    }
  }
  

/***/ }),
/* 121 */
/***/ (function(module, exports, __webpack_require__) {


    var riot = __webpack_require__(0)
    riot.tag2('docs-auth-register', '<h1>{opts.title}</h1> <h2><{opts.component}></h2> <section class="demo" ref="liveDemo"></section> <section class="options"> <form> <fieldset name="title"> <legend>Title</legend> <input onclick="{updateTextWithCheckbox}" type="checkbox" checked="{specs.title}"> <input onkeyup="{updateTextWithCheckbox}" type="text" riot-value="{specs.title}"> </fieldset> <xmp ref="inputCode" class="code">{input}</xmp> <button onclick="{handleSubmit}">Apply</button> </form> </section>', '', '', function(opts) {
'use strict';

var _this = this;

var _updateCode = __webpack_require__(2);

var _updateCode2 = _interopRequireDefault(_updateCode);

var _updateTag = __webpack_require__(3);

var _updateTag2 = _interopRequireDefault(_updateTag);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

this.input = '';
this.specs = {};
this.updateTextWithCheckbox = function (event) {
    var target = event.target.parentNode.name;
    if (event.target.type == 'checkbox') {
        var sibling = event.target.parentNode.children[2];
        event.target.checked ? _this.specs[target] = sibling.value : delete _this.specs[target];
    } else {
        var _sibling = event.target.parentNode.children[1];
        _this.specs[target] = event.target.value;
    }
    _this.handleCode();
};

this.handleCode = function () {
    (0, _updateCode2.default)(opts.component, _this.specs, _this.refs.inputCode);
};
this.handleSubmit = function (event) {
    event.preventDefault();
    (0, _updateTag2.default)(opts.component, _this.specs, _this.refs.liveDemo);
};
this.on('mount', function () {
    (0, _updateCode2.default)(opts.component, this.specs, this.refs.inputCode);
    (0, _updateTag2.default)(opts.component, this.specs, this.refs.liveDemo);
});
});
    
  if (false) {
    module.hot.accept()
    if (module.hot.data) {
      riot.reload('docs-auth-register')
    }
  }
  

/***/ }),
/* 122 */
/***/ (function(module, exports, __webpack_require__) {


    var riot = __webpack_require__(0)
    riot.tag2('docs-auth-reset', '<h1>{opts.title}</h1> <h2><{opts.component}></h2> <section class="demo" ref="liveDemo"></section> <section class="options"> <form> <fieldset name="title"> <legend>Title</legend> <input onclick="{updateTextWithCheckbox}" type="checkbox" checked="{specs.title}"> <input onkeyup="{updateTextWithCheckbox}" type="text" riot-value="{specs.title}"> </fieldset> <xmp ref="inputCode" class="code">{input}</xmp> <button onclick="{handleSubmit}">Apply</button> </form> </section>', '', '', function(opts) {
'use strict';

var _this = this;

var _updateCode = __webpack_require__(2);

var _updateCode2 = _interopRequireDefault(_updateCode);

var _updateTag = __webpack_require__(3);

var _updateTag2 = _interopRequireDefault(_updateTag);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

this.input = '';
this.specs = {};
this.updateTextWithCheckbox = function (event) {
    var target = event.target.parentNode.name;
    if (event.target.type == 'checkbox') {
        var sibling = event.target.parentNode.children[2];
        event.target.checked ? _this.specs[target] = sibling.value : delete _this.specs[target];
    } else {
        var _sibling = event.target.parentNode.children[1];
        _this.specs[target] = event.target.value;
    }
    _this.handleCode();
};

this.handleCode = function () {
    (0, _updateCode2.default)(opts.component, _this.specs, _this.refs.inputCode);
};
this.handleSubmit = function (event) {
    event.preventDefault();
    (0, _updateTag2.default)(opts.component, _this.specs, _this.refs.liveDemo);
};
this.on('mount', function () {
    (0, _updateCode2.default)(opts.component, this.specs, this.refs.inputCode);
    (0, _updateTag2.default)(opts.component, this.specs, this.refs.liveDemo);
});
});
    
  if (false) {
    module.hot.accept()
    if (module.hot.data) {
      riot.reload('docs-auth-reset')
    }
  }
  

/***/ }),
/* 123 */
/***/ (function(module, exports, __webpack_require__) {


    var riot = __webpack_require__(0)
    riot.tag2('docs-star-button', '<h1>{opts.title}</h1> <h2><{opts.component}></h2> <section class="demo" ref="liveDemo"></section> <section class="options"> <form> <fieldset name="type"> <legend>Default</legend> <div class="radiobutton"> <input onclick="{updateRadio}" type="radio" name="type" id="default" checked="{specs.type == \'default\'}"> <label for="default">Default</label> <input onclick="{updateRadio}" type="radio" name="type" id="like" checked="{specs.type == \'like\'}"> <label for="like">Like</label> <input onclick="{updateRadio}" type="radio" name="type" id="love" checked="{specs.type == \'love\'}"> <label for="love">Love</label> <input onclick="{updateRadio}" type="radio" name="type" id="save" checked="{specs.type == \'save\'}"> <label for="save">Save</label> <div> </fieldset> <xmp ref="inputCode" class="code">{input}</xmp> <button onclick="{handleSubmit}">Apply</button> </form> </section>', '', '', function(opts) {
"use strict";

var _this = this;

var _updateCode = __webpack_require__(2);

var _updateCode2 = _interopRequireDefault(_updateCode);

var _updateTag = __webpack_require__(3);

var _updateTag2 = _interopRequireDefault(_updateTag);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

this.input = '';
this.specs = {
    "type": "default"
};
this.updateRadio = function (event) {
    var target = event.target.parentNode.parentNode.name;
    _this.specs[target] = event.target.id;
    _this.handleCode();
};

this.handleCode = function () {
    (0, _updateCode2.default)(opts.component, _this.specs, _this.refs.inputCode);
};
this.handleSubmit = function (event) {
    event.preventDefault();
    (0, _updateTag2.default)(opts.component, _this.specs, _this.refs.liveDemo);
};
this.on('mount', function () {
    (0, _updateCode2.default)(opts.component, this.specs, this.refs.inputCode);
    (0, _updateTag2.default)(opts.component, this.specs, this.refs.liveDemo);
});
});
    
  if (false) {
    module.hot.accept()
    if (module.hot.data) {
      riot.reload('docs-star-button')
    }
  }
  

/***/ }),
/* 124 */
/***/ (function(module, exports, __webpack_require__) {


    var riot = __webpack_require__(0)
    riot.tag2('docs-star-list', '<h1>{opts.title}</h1> <h2><{opts.component}></h2> <section class="demo" ref="liveDemo"></section> <section class="options"> <form> <fieldset name="title"> <legend>Title</legend> <input onclick="{updateTextWithCheckbox}" type="checkbox" checked="{specs.title}"> <input onkeyup="{updateTextWithCheckbox}" type="text" riot-value="{specs.title}"> </fieldset> <fieldset name="scope"> <legend>Scope</legend> <div class="radiobutton"> <input onclick="{updateRadio}" type="radio" name="scope" id="global" checked="{specs.scope == \'global\'}"> <label for="global">Global</label> <input onclick="{updateRadio}" type="radio" name="scope" id="user" checked="{specs.scope == \'user\'}"> <label for="user">User</label> <div> </fieldset> <fieldset name="type"> <legend>Type</legend> <div class="radiobutton"> <input onclick="{updateRadio}" type="radio" name="type" id="default" checked="{specs.type == \'default\'}"> <label for="default">Default</label> <input onclick="{updateRadio}" type="radio" name="type" id="like" checked="{specs.type == \'like\'}"> <label for="like">Like</label> <input onclick="{updateRadio}" type="radio" name="type" id="love" checked="{specs.type == \'love\'}"> <label for="love">Love</label> <input onclick="{updateRadio}" type="radio" name="type" id="save" checked="{specs.type == \'save\'}"> <label for="save">Save</label> <div> </fieldset> <xmp ref="inputCode" class="code">{input}</xmp> <button onclick="{handleSubmit}">Apply</button> </form> </section>', '', '', function(opts) {
"use strict";

var _this = this;

var _updateCode = __webpack_require__(2);

var _updateCode2 = _interopRequireDefault(_updateCode);

var _updateTag = __webpack_require__(3);

var _updateTag2 = _interopRequireDefault(_updateTag);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

this.input = '';
this.specs = {
    "type": "default",
    "scope": "global"
};
this.updateTextWithCheckbox = function (event) {
    var target = event.target.parentNode.name;
    if (event.target.type == 'checkbox') {
        var sibling = event.target.parentNode.children[2];
        event.target.checked ? _this.specs[target] = sibling.value : delete _this.specs[target];
    } else {
        var _sibling = event.target.parentNode.children[1];
        _this.specs[target] = event.target.value;
    }
    _this.handleCode();
};
this.updateRadio = function (event) {
    var target = event.target.parentNode.parentNode.name;
    _this.specs[target] = event.target.id;
    _this.handleCode();
};

this.handleCode = function () {
    (0, _updateCode2.default)(opts.component, _this.specs, _this.refs.inputCode);
};
this.handleSubmit = function (event) {
    event.preventDefault();
    (0, _updateTag2.default)(opts.component, _this.specs, _this.refs.liveDemo);
};
this.on('mount', function () {
    (0, _updateCode2.default)(opts.component, this.specs, this.refs.inputCode);
    (0, _updateTag2.default)(opts.component, this.specs, this.refs.liveDemo);
});
});
    
  if (false) {
    module.hot.accept()
    if (module.hot.data) {
      riot.reload('docs-star-list')
    }
  }
  

/***/ }),
/* 125 */
/***/ (function(module, exports, __webpack_require__) {


    var riot = __webpack_require__(0)
    riot.tag2('docs-comments', '<h1>{opts.title}</h1> <h2><{opts.component}></h2> <section class="demo" ref="liveDemo"></section> <section class="options"> <form> <fieldset name="title"> <legend>Title</legend> <input onclick="{updateTextWithCheckbox}" type="checkbox" checked="{specs.title}"> <input onkeyup="{updateTextWithCheckbox}" type="text" riot-value="{specs.title}"> </fieldset> <xmp ref="inputCode" class="code">{input}</xmp> <button onclick="{handleSubmit}">Apply</button> </form> </section>', '', '', function(opts) {
'use strict';

var _this = this;

var _updateCode = __webpack_require__(2);

var _updateCode2 = _interopRequireDefault(_updateCode);

var _updateTag = __webpack_require__(3);

var _updateTag2 = _interopRequireDefault(_updateTag);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

this.input = '';
this.specs = {};
this.updateTextWithCheckbox = function (event) {
    var target = event.target.parentNode.name;
    if (event.target.type == 'checkbox') {
        var sibling = event.target.parentNode.children[2];
        event.target.checked ? _this.specs[target] = sibling.value : delete _this.specs[target];
    } else {
        var _sibling = event.target.parentNode.children[1];
        _this.specs[target] = event.target.value;
    }
    _this.handleCode();
};

this.handleCode = function () {
    (0, _updateCode2.default)(opts.component, _this.specs, _this.refs.inputCode);
};
this.handleSubmit = function (event) {
    event.preventDefault();
    (0, _updateTag2.default)(opts.component, _this.specs, _this.refs.liveDemo);
};
this.on('mount', function () {
    (0, _updateCode2.default)(opts.component, this.specs, this.refs.inputCode);
    (0, _updateTag2.default)(opts.component, this.specs, this.refs.liveDemo);
});
});
    
  if (false) {
    module.hot.accept()
    if (module.hot.data) {
      riot.reload('docs-comments')
    }
  }
  

/***/ }),
/* 126 */
/***/ (function(module, exports, __webpack_require__) {


    var riot = __webpack_require__(0)
    riot.tag2('docs-forum', '<h1>{opts.title}</h1> <h2><{opts.component}></h2> <section class="demo" ref="liveDemo"></section> <section class="options"> <form> <fieldset name="title"> <legend>Title</legend> <input onkeyup="{updateText}" type="text" riot-value="{specs.title}" placeholder="Multiple Titles (by default)"> </fieldset> <xmp ref="inputCode" class="code">{input}</xmp> <button onclick="{handleSubmit}">Apply</button> </form> </section>', '', '', function(opts) {
'use strict';

var _this = this;

var _updateCode = __webpack_require__(2);

var _updateCode2 = _interopRequireDefault(_updateCode);

var _updateTag = __webpack_require__(3);

var _updateTag2 = _interopRequireDefault(_updateTag);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

this.input = '';
this.specs = {};
this.updateText = function (event) {
    var target = event.target.parentNode.name;
    _this.specs[target] = event.target.value;
    _this.handleCode();
};

this.handleCode = function () {
    (0, _updateCode2.default)(opts.component, _this.specs, _this.refs.inputCode);
};
this.handleSubmit = function (event) {
    event.preventDefault();
    (0, _updateTag2.default)(opts.component, _this.specs, _this.refs.liveDemo);
};
this.on('mount', function () {
    (0, _updateCode2.default)(opts.component, this.specs, this.refs.inputCode);
    (0, _updateTag2.default)(opts.component, this.specs, this.refs.liveDemo);
});
});
    
  if (false) {
    module.hot.accept()
    if (module.hot.data) {
      riot.reload('docs-forum')
    }
  }
  

/***/ }),
/* 127 */
/***/ (function(module, exports, __webpack_require__) {


    var riot = __webpack_require__(0)
    riot.tag2('docs-forum-list', '<h1>{opts.title}</h1> <h2><{opts.component}></h2> <section class="demo" ref="liveDemo"></section> <section class="options"> <form> <fieldset name="title"> <legend>Title</legend> <input onkeyup="{updateText}" type="text" riot-value="{specs.title}" placeholder="Community Forum"> </fieldset> <xmp ref="inputCode" class="code">{input}</xmp> <button onclick="{handleSubmit}">Apply</button> </form> </section>', '', '', function(opts) {
'use strict';

var _this = this;

var _updateCode = __webpack_require__(2);

var _updateCode2 = _interopRequireDefault(_updateCode);

var _updateTag = __webpack_require__(3);

var _updateTag2 = _interopRequireDefault(_updateTag);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

this.input = '';
this.specs = {};
this.updateText = function (event) {
    var target = event.target.parentNode.name;
    _this.specs[target] = event.target.value;
    _this.handleCode();
};

this.handleCode = function () {
    (0, _updateCode2.default)(opts.component, _this.specs, _this.refs.inputCode);
};
this.handleSubmit = function (event) {
    event.preventDefault();
    (0, _updateTag2.default)(opts.component, _this.specs, _this.refs.liveDemo);
};
this.on('mount', function () {
    (0, _updateCode2.default)(opts.component, this.specs, this.refs.inputCode);
    (0, _updateTag2.default)(opts.component, this.specs, this.refs.liveDemo);
});
});
    
  if (false) {
    module.hot.accept()
    if (module.hot.data) {
      riot.reload('docs-forum-list')
    }
  }
  

/***/ }),
/* 128 */
/***/ (function(module, exports, __webpack_require__) {


    var riot = __webpack_require__(0)
    riot.tag2('docs-forum-thread', '<h1>{opts.title}</h1> <h2><{opts.component}></h2> <section class="demo" ref="liveDemo"></section> <section class="options"> <form> <fieldset name="title"> <legend>Title</legend> <input onkeyup="{updateText}" type="text" riot-value="{specs.title}" placeholder="Thread by USERNAME"> </fieldset> <xmp ref="inputCode" class="code">{input}</xmp> <button onclick="{handleSubmit}">Apply</button> </form> </section>', '', '', function(opts) {
"use strict";

var _this = this;

var _updateCode = __webpack_require__(2);

var _updateCode2 = _interopRequireDefault(_updateCode);

var _updateTag = __webpack_require__(3);

var _updateTag2 = _interopRequireDefault(_updateTag);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

this.input = '';
this.specs = {
    "id": "57dd66ff28c179bf867035a89a8c2d56"
};
this.updateText = function (event) {
    var target = event.target.parentNode.name;
    _this.specs[target] = event.target.value;
    _this.handleCode();
};

this.handleCode = function () {
    (0, _updateCode2.default)(opts.component, _this.specs, _this.refs.inputCode);
};
this.handleSubmit = function (event) {
    event.preventDefault();
    (0, _updateTag2.default)(opts.component, _this.specs, _this.refs.liveDemo);
};
this.on('mount', function () {
    (0, _updateCode2.default)(opts.component, this.specs, this.refs.inputCode);
    (0, _updateTag2.default)(opts.component, this.specs, this.refs.liveDemo);
});
});
    
  if (false) {
    module.hot.accept()
    if (module.hot.data) {
      riot.reload('docs-forum-thread')
    }
  }
  

/***/ }),
/* 129 */
/***/ (function(module, exports, __webpack_require__) {


    var riot = __webpack_require__(0)
    riot.tag2('docs-forum-compose', '<h1>{opts.title}</h1> <h2><{opts.component}></h2> <section class="demo" ref="liveDemo"></section> <section class="options"> <form> <fieldset name="title"> <legend>Title</legend> <input onkeyup="{updateText}" type="text" riot-value="{specs.title}" placeholder="New Thread"> </fieldset> <xmp ref="inputCode" class="code">{input}</xmp> <button onclick="{handleSubmit}">Apply</button> </form> </section>', '', '', function(opts) {
'use strict';

var _this = this;

var _updateCode = __webpack_require__(2);

var _updateCode2 = _interopRequireDefault(_updateCode);

var _updateTag = __webpack_require__(3);

var _updateTag2 = _interopRequireDefault(_updateTag);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

this.input = '';
this.specs = {};
this.updateText = function (event) {
    var target = event.target.parentNode.name;
    _this.specs[target] = event.target.value;
    _this.handleCode();
};

this.handleCode = function () {
    (0, _updateCode2.default)(opts.component, _this.specs, _this.refs.inputCode);
};
this.handleSubmit = function (event) {
    event.preventDefault();
    (0, _updateTag2.default)(opts.component, _this.specs, _this.refs.liveDemo);
};
this.on('mount', function () {
    (0, _updateCode2.default)(opts.component, this.specs, this.refs.inputCode);
    (0, _updateTag2.default)(opts.component, this.specs, this.refs.liveDemo);
});
});
    
  if (false) {
    module.hot.accept()
    if (module.hot.data) {
      riot.reload('docs-forum-compose')
    }
  }
  

/***/ }),
/* 130 */
/***/ (function(module, exports, __webpack_require__) {


    var riot = __webpack_require__(0)
    riot.tag2('docs-group', '<h1>{opts.title}</h1> <h2><{opts.component}></h2> <section class="demo" ref="liveDemo"></section> <section class="options"> <form> <fieldset name="id"> <legend>Identification</legend> <input onclick="{updateTextWithCheckbox}" type="checkbox" checked="{specs.id}"> <input onkeyup="{updateTextWithCheckbox}" type="text" riot-value="{specs.id}"> </fieldset> <xmp ref="inputCode" class="code">{input}</xmp> <button onclick="{handleSubmit}">Apply</button> </form> </section>', '', '', function(opts) {
"use strict";

var _this = this;

var _updateCode = __webpack_require__(2);

var _updateCode2 = _interopRequireDefault(_updateCode);

var _updateTag = __webpack_require__(3);

var _updateTag2 = _interopRequireDefault(_updateTag);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

this.input = '';
this.specs = {
    "id": "3cd7770e85489aea90479aac0ebe21d6"
};
this.updateTextWithCheckbox = function (event) {
    var target = event.target.parentNode.name;
    if (event.target.type == 'checkbox') {
        var sibling = event.target.parentNode.children[2];
        event.target.checked ? _this.specs[target] = sibling.value : delete _this.specs[target];
    } else {
        var _sibling = event.target.parentNode.children[1];
        _this.specs[target] = event.target.value;
    }
    _this.handleCode();
};

this.handleCode = function () {
    (0, _updateCode2.default)(opts.component, _this.specs, _this.refs.inputCode);
};
this.handleSubmit = function (event) {
    event.preventDefault();
    (0, _updateTag2.default)(opts.component, _this.specs, _this.refs.liveDemo);
};
this.on('mount', function () {
    (0, _updateCode2.default)(opts.component, this.specs, this.refs.inputCode);
    (0, _updateTag2.default)(opts.component, this.specs, this.refs.liveDemo);
});
});
    
  if (false) {
    module.hot.accept()
    if (module.hot.data) {
      riot.reload('docs-group')
    }
  }
  

/***/ }),
/* 131 */
/***/ (function(module, exports, __webpack_require__) {


    var riot = __webpack_require__(0)
    riot.tag2('docs-group-card', '<h1>{opts.title}</h1> <h2><{opts.component}></h2> <section class="demo" ref="liveDemo"></section> <section class="options"> <form> <fieldset name="id"> <legend>Identification</legend> <input onclick="{updateTextWithCheckbox}" type="checkbox" checked="{specs.id}"> <input onkeyup="{updateTextWithCheckbox}" type="text" riot-value="{specs.id}"> </fieldset> <fieldset name="theme"> <legend>Theme</legend> <div class="radiobutton"> <input onclick="{updateRadio}" type="radio" name="theme" id="default" checked="{specs.theme == \'default\'}"> <label for="default">Default</label> <input onclick="{updateRadio}" type="radio" name="theme" id="color" checked="{specs.theme == \'color\'}"> <label for="color">Color</label> <div> </fieldset> <xmp ref="inputCode" class="code">{input}</xmp> <button onclick="{handleSubmit}">Apply</button> </form> </section>', '', '', function(opts) {
"use strict";

var _this = this;

var _updateCode = __webpack_require__(2);

var _updateCode2 = _interopRequireDefault(_updateCode);

var _updateTag = __webpack_require__(3);

var _updateTag2 = _interopRequireDefault(_updateTag);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

this.input = '';
this.specs = {
    "id": "3cd7770e85489aea90479aac0ebe21d6",
    "theme": "default"
};
this.updateTextWithCheckbox = function (event) {
    var target = event.target.parentNode.name;
    if (event.target.type == 'checkbox') {
        var sibling = event.target.parentNode.children[2];
        event.target.checked ? _this.specs[target] = sibling.value : delete _this.specs[target];
    } else {
        var _sibling = event.target.parentNode.children[1];
        _this.specs[target] = event.target.value;
    }
    _this.handleCode();
};
this.updateRadio = function (event) {
    var target = event.target.parentNode.parentNode.name;
    _this.specs[target] = event.target.id;
    _this.handleCode();
};

this.handleCode = function () {
    (0, _updateCode2.default)(opts.component, _this.specs, _this.refs.inputCode);
};
this.handleSubmit = function (event) {
    event.preventDefault();
    (0, _updateTag2.default)(opts.component, _this.specs, _this.refs.liveDemo);
};
this.on('mount', function () {
    (0, _updateCode2.default)(opts.component, this.specs, this.refs.inputCode);
    (0, _updateTag2.default)(opts.component, this.specs, this.refs.liveDemo);
});
});
    
  if (false) {
    module.hot.accept()
    if (module.hot.data) {
      riot.reload('docs-group-card')
    }
  }
  

/***/ }),
/* 132 */
/***/ (function(module, exports, __webpack_require__) {


    var riot = __webpack_require__(0)
    riot.tag2('docs-messages', '<h1>{opts.title}</h1> <h2><{opts.component}></h2> <section class="demo" ref="liveDemo"></section> <section class="options"> <form> <fieldset name="title"> <legend>Title</legend> <input onclick="{updateTextWithCheckbox}" type="checkbox" checked="{specs.title}"> <input onkeyup="{updateTextWithCheckbox}" type="text" riot-value="{specs.title}"> </fieldset> <xmp ref="inputCode" class="code">{input}</xmp> <button onclick="{handleSubmit}">Apply</button> </form> </section>', '', '', function(opts) {
'use strict';

var _this = this;

var _updateCode = __webpack_require__(2);

var _updateCode2 = _interopRequireDefault(_updateCode);

var _updateTag = __webpack_require__(3);

var _updateTag2 = _interopRequireDefault(_updateTag);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

this.input = '';
this.specs = {};
this.updateTextWithCheckbox = function (event) {
    var target = event.target.parentNode.name;
    if (event.target.type == 'checkbox') {
        var sibling = event.target.parentNode.children[2];
        event.target.checked ? _this.specs[target] = sibling.value : delete _this.specs[target];
    } else {
        var _sibling = event.target.parentNode.children[1];
        _this.specs[target] = event.target.value;
    }
    _this.handleCode();
};

this.handleCode = function () {
    (0, _updateCode2.default)(opts.component, _this.specs, _this.refs.inputCode);
};
this.handleSubmit = function (event) {
    event.preventDefault();
    (0, _updateTag2.default)(opts.component, _this.specs, _this.refs.liveDemo);
};
this.on('mount', function () {
    (0, _updateCode2.default)(opts.component, this.specs, this.refs.inputCode);
    (0, _updateTag2.default)(opts.component, this.specs, this.refs.liveDemo);
});
});
    
  if (false) {
    module.hot.accept()
    if (module.hot.data) {
      riot.reload('docs-messages')
    }
  }
  

/***/ }),
/* 133 */
/***/ (function(module, exports, __webpack_require__) {


    var riot = __webpack_require__(0)
    riot.tag2('docs-profile', '<h1>{opts.title}</h1> <h2><{opts.component}></h2> <section class="demo" ref="liveDemo"></section> <section class="options"> <form> <fieldset name="id"> <legend>Identification</legend> <input onclick="{updateTextWithCheckbox}" type="checkbox" checked="{specs.id}"> <input onkeyup="{updateTextWithCheckbox}" type="text" riot-value="{specs.id}"> </fieldset> <xmp ref="inputCode" class="code">{input}</xmp> <button onclick="{handleSubmit}">Apply</button> </form> </section>', '', '', function(opts) {
"use strict";

var _this = this;

var _updateCode = __webpack_require__(2);

var _updateCode2 = _interopRequireDefault(_updateCode);

var _updateTag = __webpack_require__(3);

var _updateTag2 = _interopRequireDefault(_updateTag);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

this.input = '';
this.specs = {
    "id": "4254d4931b6ec83d4fa10b2593f85643"
};
this.updateTextWithCheckbox = function (event) {
    var target = event.target.parentNode.name;
    if (event.target.type == 'checkbox') {
        var sibling = event.target.parentNode.children[2];
        event.target.checked ? _this.specs[target] = sibling.value : delete _this.specs[target];
    } else {
        var _sibling = event.target.parentNode.children[1];
        _this.specs[target] = event.target.value;
    }
    _this.handleCode();
};

this.handleCode = function () {
    (0, _updateCode2.default)(opts.component, _this.specs, _this.refs.inputCode);
};
this.handleSubmit = function (event) {
    event.preventDefault();
    (0, _updateTag2.default)(opts.component, _this.specs, _this.refs.liveDemo);
};
this.on('mount', function () {
    (0, _updateCode2.default)(opts.component, this.specs, this.refs.inputCode);
    (0, _updateTag2.default)(opts.component, this.specs, this.refs.liveDemo);
});
});
    
  if (false) {
    module.hot.accept()
    if (module.hot.data) {
      riot.reload('docs-profile')
    }
  }
  

/***/ }),
/* 134 */
/***/ (function(module, exports, __webpack_require__) {


    var riot = __webpack_require__(0)
    riot.tag2('docs-profile-card', '<h1>{opts.title}</h1> <h2><{opts.component}></h2> <section class="demo" ref="liveDemo"></section> <section class="options"> <form> <fieldset name="id"> <legend>Identification</legend> <input onclick="{updateTextWithCheckbox}" type="checkbox" checked="{specs.id}"> <input onkeyup="{updateTextWithCheckbox}" type="text" riot-value="{specs.id}"> </fieldset> <fieldset name="theme"> <legend>Theme</legend> <div class="radiobutton"> <input onclick="{updateRadio}" type="radio" name="theme" id="default" checked="{specs.theme == \'default\'}"> <label for="default">Default</label> <input onclick="{updateRadio}" type="radio" name="theme" id="color" checked="{specs.theme == \'color\'}"> <label for="color">Color</label> <div> </fieldset> <xmp ref="inputCode" class="code">{input}</xmp> <button onclick="{handleSubmit}">Apply</button> </form> </section>', '', '', function(opts) {
"use strict";

var _this = this;

var _updateCode = __webpack_require__(2);

var _updateCode2 = _interopRequireDefault(_updateCode);

var _updateTag = __webpack_require__(3);

var _updateTag2 = _interopRequireDefault(_updateTag);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

this.input = '';
this.specs = {
    "id": "4254d4931b6ec83d4fa10b2593f85643",
    "theme": "default"
};
this.updateTextWithCheckbox = function (event) {
    var target = event.target.parentNode.name;
    if (event.target.type == 'checkbox') {
        var sibling = event.target.parentNode.children[2];
        event.target.checked ? _this.specs[target] = sibling.value : delete _this.specs[target];
    } else {
        var _sibling = event.target.parentNode.children[1];
        _this.specs[target] = event.target.value;
    }
    _this.handleCode();
};
this.updateRadio = function (event) {
    var target = event.target.parentNode.parentNode.name;
    _this.specs[target] = event.target.id;
    _this.handleCode();
};

this.handleCode = function () {
    (0, _updateCode2.default)(opts.component, _this.specs, _this.refs.inputCode);
};
this.handleSubmit = function (event) {
    event.preventDefault();
    (0, _updateTag2.default)(opts.component, _this.specs, _this.refs.liveDemo);
};
this.on('mount', function () {
    (0, _updateCode2.default)(opts.component, this.specs, this.refs.inputCode);
    (0, _updateTag2.default)(opts.component, this.specs, this.refs.liveDemo);
});
});
    
  if (false) {
    module.hot.accept()
    if (module.hot.data) {
      riot.reload('docs-profile-card')
    }
  }
  

/***/ }),
/* 135 */
/***/ (function(module, exports, __webpack_require__) {


    var riot = __webpack_require__(0)
    riot.tag2('docs-state', '<h1>{opts.title}</h1> <h2><{opts.component}></h2> <section class="demo" ref="liveDemo"></section> <section class="options"> <form> <fieldset name="theme"> <legend>Theme</legend> <div class="radiobutton"> <input onclick="{updateRadio}" type="radio" name="theme" id="default" checked="{specs.theme == \'default\'}"> <label for="default">Default</label> <input onclick="{updateRadio}" type="radio" name="theme" id="color" checked="{specs.theme == \'color\'}"> <label for="color">Color</label> <div> </fieldset> <xmp ref="inputCode" class="code">{input}</xmp> <button onclick="{handleSubmit}">Apply</button> </form> </section>', '', '', function(opts) {
"use strict";

var _this = this;

var _updateCode = __webpack_require__(2);

var _updateCode2 = _interopRequireDefault(_updateCode);

var _updateTag = __webpack_require__(3);

var _updateTag2 = _interopRequireDefault(_updateTag);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

this.input = '';
this.specs = {
    "theme": "default"
};
this.updateRadio = function (event) {
    var target = event.target.parentNode.parentNode.name;
    _this.specs[target] = event.target.id;
    _this.handleCode();
};

this.handleCode = function () {
    (0, _updateCode2.default)(opts.component, _this.specs, _this.refs.inputCode);
};
this.handleSubmit = function (event) {
    event.preventDefault();
    (0, _updateTag2.default)(opts.component, _this.specs, _this.refs.liveDemo);
};
this.on('mount', function () {
    (0, _updateCode2.default)(opts.component, this.specs, this.refs.inputCode);
    (0, _updateTag2.default)(opts.component, this.specs, this.refs.liveDemo);
});
});
    
  if (false) {
    module.hot.accept()
    if (module.hot.data) {
      riot.reload('docs-state')
    }
  }
  

/***/ }),
/* 136 */
/***/ (function(module, exports, __webpack_require__) {


var content = __webpack_require__(137);

if(typeof content === 'string') content = [[module.i, content, '']];

var transform;
var insertInto;



var options = {"hmr":true}

options.transform = transform
options.insertInto = undefined;

var update = __webpack_require__(142)(content, options);

if(content.locals) module.exports = content.locals;

if(false) {
	module.hot.accept("!!../../node_modules/css-loader/index.js!../../node_modules/less-loader/dist/cjs.js!./common.less", function() {
		var newContent = require("!!../../node_modules/css-loader/index.js!../../node_modules/less-loader/dist/cjs.js!./common.less");

		if(typeof newContent === 'string') newContent = [[module.id, newContent, '']];

		var locals = (function(a, b) {
			var key, idx = 0;

			for(key in a) {
				if(!b || a[key] !== b[key]) return false;
				idx++;
			}

			for(key in b) idx--;

			return idx === 0;
		}(content.locals, newContent.locals));

		if(!locals) throw new Error('Aborting CSS HMR due to changed css-modules locals.');

		update(newContent);
	});

	module.hot.dispose(function() { update(); });
}

/***/ }),
/* 137 */
/***/ (function(module, exports, __webpack_require__) {

var escape = __webpack_require__(138);
exports = module.exports = __webpack_require__(139)(false);
// imports


// module
exports.push([module.i, "graphjs-star-list {\n  color: rgba(63, 95, 127, 0.65);\n}\ngraphjs-star-list .content .list .item {\n  color: #6f879f;\n}\ngraphjs-star-list .content .list .item.placeholder {\n  color: #9fafbf;\n}\ngraphjs-star-list .content .list .item .title {\n  color: #3f5f7f;\n}\ngraphjs-star-list .content .list .item .count svg path {\n  fill: #6f879f;\n}\n.graphjs-theme-light input,\n.graphjs-theme-light textarea {\n  color: #9fafbf;\n  background-color: white;\n}\n.graphjs-theme-light input::-webkit-input-placeholder,\n.graphjs-theme-light textarea::-webkit-input-placeholder,\n.graphjs-theme-light input::placeholder,\n.graphjs-theme-light textarea::placeholder {\n  color: #9fafbf;\n}\n.graphjs-theme-light input::-moz-placeholder,\n.graphjs-theme-light textarea::-moz-placeholder,\n.graphjs-theme-light input:-ms-input-placeholder,\n.graphjs-theme-light textarea:-ms-input-placeholder,\n.graphjs-theme-light input:-moz-placeholder,\n.graphjs-theme-light textarea:-moz-placeholder {\n  color: #9fafbf;\n}\n.graphjs-theme-light input:focus::-webkit-input-placeholder,\n.graphjs-theme-light textarea:focus::-webkit-input-placeholder,\n.graphjs-theme-light input:focus::placeholder,\n.graphjs-theme-light textarea:focus::placeholder {\n  opacity: .5;\n}\n.graphjs-theme-light input:focus::-moz-placeholder,\n.graphjs-theme-light textarea:focus::-moz-placeholder,\n.graphjs-theme-light input:focus:-ms-input-placeholder,\n.graphjs-theme-light textarea:focus:-ms-input-placeholder,\n.graphjs-theme-light input:focus:-moz-placeholder,\n.graphjs-theme-light textarea:focus:-moz-placeholder {\n  opacity: .5;\n}\n.graphjs-theme-light form .option a {\n  color: #6f879f;\n}\n.graphjs-theme-light .box {\n  border: 1px solid rgba(63, 95, 127, 0.03);\n  background-color: #f5f7f9;\n}\n.graphjs-theme-light .box .header {\n  border-bottom: 2px solid rgba(63, 95, 127, 0.1);\n  background-color: white;\n}\n.graphjs-theme-light .box .header + .warning {\n  color: white;\n}\n.graphjs-theme-light .box .warning {\n  border-bottom: 1px solid rgba(63, 95, 127, 0.15);\n}\n.graphjs-theme-light .box .content {\n  background-color: #f5f7f9;\n}\n.graphjs-theme-light .card {\n  background-color: white;\n}\n.graphjs-theme-light .card .information p {\n  color: #6f879f;\n}\n.graphjs-theme-light .credit span small,\n.graphjs-theme-light .credit span time {\n  color: #9fafbf;\n}\n.graphjs-theme-light graphjs-alert {\n  color: rgba(63, 95, 127, 0.65);\n}\n.graphjs-theme-light graphjs-alert > button {\n  background-color: white !important;\n}\n.graphjs-theme-light graphjs-alert > button:hover {\n  background-color: white !important;\n}\n.graphjs-theme-light graphjs-alert > button.danger {\n  background-color: white;\n}\n.graphjs-theme-light graphjs-auth {\n  color: rgba(63, 95, 127, 0.65);\n}\n.graphjs-theme-light graphjs-auth-login {\n  color: rgba(63, 95, 127, 0.65);\n}\n.graphjs-theme-light graphjs-auth-register {\n  color: rgba(63, 95, 127, 0.65);\n}\n.graphjs-theme-light graphjs-auth-reset {\n  color: rgba(63, 95, 127, 0.65);\n}\n.graphjs-theme-light graphjs-comments {\n  color: rgba(63, 95, 127, 0.65);\n  background-color: #f5f7f9;\n}\n.graphjs-theme-light graphjs-comments .item .credit span {\n  color: #6f879f;\n}\n.graphjs-theme-light graphjs-forum {\n  color: rgba(63, 95, 127, 0.65);\n}\n.graphjs-theme-light graphjs-forum-compose {\n  color: rgba(63, 95, 127, 0.65);\n}\n.graphjs-theme-light graphjs-forum-list {\n  color: rgba(63, 95, 127, 0.65);\n}\n.graphjs-theme-light graphjs-forum-list .content .bar .search {\n  border-right: 2px solid white;\n}\n.graphjs-theme-light graphjs-forum-list .content .list .item {\n  color: #6f879f;\n}\n.graphjs-theme-light graphjs-forum-list .content .list .item .title {\n  color: #3f5f7f;\n}\n.graphjs-theme-light graphjs-forum-list .content .list .item .views svg path {\n  fill: #6f879f;\n}\n.graphjs-theme-light graphjs-forum-thread {\n  color: rgba(63, 95, 127, 0.65);\n}\n.graphjs-theme-light graphjs-forum-thread .content .thread .title {\n  background-color: rgba(255, 255, 255, 0.5);\n}\n.graphjs-theme-light graphjs-forum-thread .content .thread .title h1 {\n  color: #3f5f7f;\n}\n.graphjs-theme-light graphjs-forum-thread .content .thread .replies {\n  background-color: #f5f7f9;\n}\n.graphjs-theme-light graphjs-forum-thread .content .thread .replies .item .credit span {\n  color: #6f879f;\n}\n.graphjs-theme-light graphjs-forum-thread .content .reply {\n  background-color: white;\n}\n.graphjs-theme-light graphjs-forum-thread .content .reply .synopsis {\n  background-color: white;\n}\n.graphjs-theme-light graphjs-messages {\n  color: rgba(63, 95, 127, 0.65);\n}\n.graphjs-theme-light graphjs-messages .content .sidebar .item {\n  border-right: 1px solid rgba(63, 95, 127, 0.15);\n  border-bottom: 1px solid rgba(63, 95, 127, 0.15);\n}\n.graphjs-theme-light graphjs-messages .content .sidebar .item.active {\n  background-color: white !important;\n}\n.graphjs-theme-light graphjs-messages .content .sidebar .item div {\n  color: #6f879f;\n}\n.graphjs-theme-light graphjs-messages .content .sidebar .item div b {\n  color: #3f5f7f;\n}\n.graphjs-theme-light graphjs-messages .content .main {\n  background-color: white;\n}\n.graphjs-theme-light graphjs-messages .content .main .conversation .item.inbound p {\n  color: #6f879f;\n  background-color: #f5f7f9;\n}\n.graphjs-theme-light graphjs-messages .content .main .conversation .item time {\n  color: #9fafbf;\n}\n.graphjs-theme-light graphjs-overlay {\n  color: rgba(63, 95, 127, 0.65);\n}\n.graphjs-theme-light graphjs-profile-card {\n  color: rgba(63, 95, 127, 0.65);\n}\n.graphjs-theme-light graphjs-profile-card .information img {\n  border: 4px solid rgba(63, 95, 127, 0.15);\n}\n.graphjs-theme-light graphjs-profile-header {\n  color: rgba(63, 95, 127, 0.65);\n}\n.graphjs-theme-light graphjs-profile-header .information img {\n  border: 4px solid rgba(63, 95, 127, 0.15);\n}\n.graphjs-theme-light graphjs-profile-header .information p {\n  color: #6f879f;\n}\n.graphjs-theme-light graphjs-group-card {\n  color: rgba(63, 95, 127, 0.65);\n}\n.graphjs-theme-light graphjs-state {\n  color: rgba(63, 95, 127, 0.65);\n  background-color: white;\n}\n.graphjs-theme-light graphjs-state a {\n  border-right: 1px dotted rgba(63, 95, 127, 0.2);\n}\n.graphjs-theme-light graphjs-state .logged .exit svg path {\n  fill: #9fafbf;\n}\n.graphjs-theme-light graphjs-state.color {\n  background-color: #007fff;\n}\n.graphjs-theme-light graphjs-state.color a {\n  border-right: 1px dotted rgba(255, 255, 255, 0.2);\n}\n.graphjs-theme-light graphjs-state.color .logged .exit svg path {\n  fill: white;\n}\n.graphjs-theme-light graphjs-star-button {\n  color: #6f879f;\n}\n.graphjs-theme-light graphjs-star-button:hover {\n  background-color: white;\n}\n.graphjs-theme-light graphjs-star-button a .text {\n  color: #6f879f;\n}\n.graphjs-theme-dark input,\n.graphjs-theme-dark textarea {\n  color: #9f9f9f;\n  background-color: #474747;\n}\n.graphjs-theme-dark input::-webkit-input-placeholder,\n.graphjs-theme-dark textarea::-webkit-input-placeholder,\n.graphjs-theme-dark input::placeholder,\n.graphjs-theme-dark textarea::placeholder {\n  color: #9f9f9f;\n}\n.graphjs-theme-dark input::-moz-placeholder,\n.graphjs-theme-dark textarea::-moz-placeholder,\n.graphjs-theme-dark input:-ms-input-placeholder,\n.graphjs-theme-dark textarea:-ms-input-placeholder,\n.graphjs-theme-dark input:-moz-placeholder,\n.graphjs-theme-dark textarea:-moz-placeholder {\n  color: #9f9f9f;\n}\n.graphjs-theme-dark input:focus::-webkit-input-placeholder,\n.graphjs-theme-dark textarea:focus::-webkit-input-placeholder,\n.graphjs-theme-dark input:focus::placeholder,\n.graphjs-theme-dark textarea:focus::placeholder {\n  opacity: .5;\n}\n.graphjs-theme-dark input:focus::-moz-placeholder,\n.graphjs-theme-dark textarea:focus::-moz-placeholder,\n.graphjs-theme-dark input:focus:-ms-input-placeholder,\n.graphjs-theme-dark textarea:focus:-ms-input-placeholder,\n.graphjs-theme-dark input:focus:-moz-placeholder,\n.graphjs-theme-dark textarea:focus:-moz-placeholder {\n  opacity: .5;\n}\n.graphjs-theme-dark form .option a {\n  color: #cfcfcf;\n}\n.graphjs-theme-dark .box {\n  border: 1px solid rgba(63, 63, 63, 0.03);\n  background-color: #3c3c3c;\n}\n.graphjs-theme-dark .box .header {\n  border-bottom: 2px solid rgba(63, 63, 63, 0.1);\n  background-color: #474747;\n}\n.graphjs-theme-dark .box .header + .warning {\n  color: #474747;\n}\n.graphjs-theme-dark .box .warning {\n  border-bottom: 1px solid rgba(63, 63, 63, 0.15);\n}\n.graphjs-theme-dark .box .content {\n  background-color: #3c3c3c;\n}\n.graphjs-theme-dark .card {\n  background-color: #474747;\n}\n.graphjs-theme-dark .card .information p {\n  color: #cfcfcf;\n}\n.graphjs-theme-dark .credit span small,\n.graphjs-theme-dark .credit span time {\n  color: #dfdfdf;\n}\n.graphjs-theme-dark graphjs-alert {\n  color: rgba(191, 191, 191, 0.65);\n}\n.graphjs-theme-dark graphjs-alert > button {\n  background-color: #474747 !important;\n}\n.graphjs-theme-dark graphjs-alert > button:hover {\n  background-color: #474747 !important;\n}\n.graphjs-theme-dark graphjs-alert > button.danger {\n  background-color: #474747;\n}\n.graphjs-theme-dark graphjs-auth {\n  color: rgba(191, 191, 191, 0.65);\n}\n.graphjs-theme-dark graphjs-auth-login {\n  color: rgba(191, 191, 191, 0.65);\n}\n.graphjs-theme-dark graphjs-auth-register {\n  color: rgba(191, 191, 191, 0.65);\n}\n.graphjs-theme-dark graphjs-auth-reset {\n  color: rgba(191, 191, 191, 0.65);\n}\n.graphjs-theme-dark graphjs-comments {\n  color: rgba(191, 191, 191, 0.65);\n  background-color: #3c3c3c;\n}\n.graphjs-theme-dark graphjs-comments .item .credit span {\n  color: #cfcfcf;\n}\n.graphjs-theme-dark graphjs-forum {\n  color: rgba(191, 191, 191, 0.65);\n}\n.graphjs-theme-dark graphjs-forum-compose {\n  color: rgba(191, 191, 191, 0.65);\n}\n.graphjs-theme-dark graphjs-forum-list {\n  color: rgba(191, 191, 191, 0.65);\n}\n.graphjs-theme-dark graphjs-forum-list .content .bar .search {\n  border-right: 2px solid #474747;\n}\n.graphjs-theme-dark graphjs-forum-list .content .list .item {\n  color: #cfcfcf;\n}\n.graphjs-theme-dark graphjs-forum-list .content .list .item .title {\n  color: #bfbfbf;\n}\n.graphjs-theme-dark graphjs-forum-list .content .list .item .views svg path {\n  fill: #cfcfcf;\n}\n.graphjs-theme-dark graphjs-forum-thread {\n  color: rgba(191, 191, 191, 0.65);\n}\n.graphjs-theme-dark graphjs-forum-thread .content .thread .title {\n  background-color: rgba(71, 71, 71, 0.5);\n}\n.graphjs-theme-dark graphjs-forum-thread .content .thread .title h1 {\n  color: #bfbfbf;\n}\n.graphjs-theme-dark graphjs-forum-thread .content .thread .replies {\n  background-color: #3c3c3c;\n}\n.graphjs-theme-dark graphjs-forum-thread .content .thread .replies .item .credit span {\n  color: #cfcfcf;\n}\n.graphjs-theme-dark graphjs-forum-thread .content .reply {\n  background-color: #474747;\n}\n.graphjs-theme-dark graphjs-forum-thread .content .reply .synopsis {\n  background-color: #474747;\n}\n.graphjs-theme-dark graphjs-messages {\n  color: rgba(191, 191, 191, 0.65);\n}\n.graphjs-theme-dark graphjs-messages .content .sidebar .item {\n  border-right: 1px solid rgba(63, 63, 63, 0.15);\n  border-bottom: 1px solid rgba(63, 63, 63, 0.15);\n}\n.graphjs-theme-dark graphjs-messages .content .sidebar .item.active {\n  background-color: #474747 !important;\n}\n.graphjs-theme-dark graphjs-messages .content .sidebar .item div {\n  color: #cfcfcf;\n}\n.graphjs-theme-dark graphjs-messages .content .sidebar .item div b {\n  color: #bfbfbf;\n}\n.graphjs-theme-dark graphjs-messages .content .main {\n  background-color: #474747;\n}\n.graphjs-theme-dark graphjs-messages .content .main .conversation .item.inbound p {\n  color: #cfcfcf;\n  background-color: #3c3c3c;\n}\n.graphjs-theme-dark graphjs-messages .content .main .conversation .item time {\n  color: #dfdfdf;\n}\n.graphjs-theme-dark graphjs-overlay {\n  color: rgba(191, 191, 191, 0.65);\n}\n.graphjs-theme-dark graphjs-profile-card {\n  color: rgba(191, 191, 191, 0.65);\n}\n.graphjs-theme-dark graphjs-profile-card .information img {\n  border: 4px solid rgba(63, 63, 63, 0.15);\n}\n.graphjs-theme-dark graphjs-profile-header {\n  color: rgba(191, 191, 191, 0.65);\n}\n.graphjs-theme-dark graphjs-profile-header .information img {\n  border: 4px solid rgba(63, 63, 63, 0.15);\n}\n.graphjs-theme-dark graphjs-profile-header .information p {\n  color: #cfcfcf;\n}\n.graphjs-theme-dark graphjs-group-card {\n  color: rgba(191, 191, 191, 0.65);\n}\n.graphjs-theme-dark graphjs-state {\n  color: rgba(191, 191, 191, 0.65);\n  background-color: #474747;\n}\n.graphjs-theme-dark graphjs-state a {\n  border-right: 1px dotted rgba(63, 63, 63, 0.2);\n}\n.graphjs-theme-dark graphjs-state .logged .exit svg path {\n  fill: #dfdfdf;\n}\n.graphjs-theme-dark graphjs-state.color {\n  background-color: #007fff;\n}\n.graphjs-theme-dark graphjs-state.color a {\n  border-right: 1px dotted rgba(255, 255, 255, 0.2);\n}\n.graphjs-theme-dark graphjs-state.color .logged .exit svg path {\n  fill: white;\n}\n.graphjs-theme-dark graphjs-star-button {\n  color: #cfcfcf;\n}\n.graphjs-theme-dark graphjs-star-button:hover {\n  background-color: #474747;\n}\n.graphjs-theme-dark graphjs-star-button a .text {\n  color: #cfcfcf;\n}\n@font-face {\n  font-family: \"Rubik\";\n  src: url(" + escape(__webpack_require__(75)) + ") format(\"woff\");\n  font-weight: 400;\n}\n@font-face {\n  font-family: \"Rubik\";\n  src: url(" + escape(__webpack_require__(75)) + ") format(\"woff\");\n  font-weight: 500;\n}\n@font-face {\n  font-family: \"Rubik\";\n  src: url(" + escape(__webpack_require__(140)) + ") format(\"woff\");\n  font-weight: 700;\n}\n@font-face {\n  font-family: \"Rubik\";\n  src: url(" + escape(__webpack_require__(141)) + ") format(\"woff\");\n  font-weight: 800;\n}\n/* ### Elements ### */\n* {\n  -webkit-box-sizing: border-box;\n  -moz-box-sizing: border-box;\n  box-sizing: border-box;\n}\n*::-webkit-input-placeholder,\n*::placeholder {\n  color: #9fafbf;\n}\n*::-moz-placeholder,\n*:-ms-input-placeholder,\n*:-moz-placeholder {\n  color: #9fafbf;\n}\n*:focus::-webkit-input-placeholder,\n*:focus::placeholder {\n  opacity: .5;\n}\n*:focus::-moz-placeholder,\n*:focus:-ms-input-placeholder,\n*:focus:-moz-placeholder {\n  opacity: .5;\n}\nbody {\n  font-size: 14px;\n  line-height: 14px;\n  color: rgba(63, 95, 127, 0.65);\n  font-family: \"Rubik\";\n  font-weight: 400;\n  letter-spacing: -0.0075em;\n}\na {\n  cursor: pointer;\n  color: #007fff;\n  text-decoration: none;\n}\nb {\n  font-family: \"Rubik\";\n  font-weight: 700;\n}\nsvg {\n  pointer-events: none;\n}\ninput,\ntextarea,\nbutton {\n  width: 100%;\n  padding: .75em 1em;\n  border: none;\n  -webkit-border-radius: 3px;\n  -moz-border-radius: 3px;\n  border-radius: 3px;\n  -moz-background-clip: padding;\n  -webkit-background-clip: padding-box;\n  background-clip: padding-box;\n  outline: none;\n}\ninput,\ntextarea {\n  color: #9fafbf;\n  font-family: \"Rubik\";\n  font-weight: 400;\n  font-size: 14px;\n  line-height: 14px;\n  border: 1px solid rgba(63, 95, 127, 0.15);\n  background-color: white;\n}\ntextarea {\n  resize: none;\n}\nbutton {\n  cursor: pointer;\n  font-size: 15.4px;\n  color: white;\n  font-family: \"Rubik\";\n  font-weight: 800;\n  overflow: hidden;\n  text-overflow: ellipsis;\n  white-space: nowrap;\n  text-transform: uppercase;\n  -webkit-transition: background-color 0.35s ease;\n  -moz-transition: background-color 0.35s ease;\n  -ms-transition: background-color 0.35s ease;\n  -o-transition: background-color 0.35s ease;\n  background-color: #697b8c;\n}\nbutton:hover {\n  background-color: #788898;\n}\nbutton:active {\n  background-color: #5f6f7e;\n}\nbutton[disabled] {\n  opacity: .5;\n}\nbutton.danger {\n  background-color: #ff4f4f;\n}\nbutton.danger:hover {\n  background-color: #ff6161;\n}\nbutton.danger:active {\n  background-color: #e64747;\n}\nform input,\nform textarea {\n  margin-bottom: .5em;\n  -webkit-transition: border-color 0.35s ease;\n  -moz-transition: border-color 0.35s ease;\n  -ms-transition: border-color 0.35s ease;\n  -o-transition: border-color 0.35s ease;\n}\nform input.error,\nform textarea.error {\n  border-color: #ff4f4f;\n}\nform input + button,\nform textarea + button {\n  margin-top: .25em;\n}\nform .option {\n  display: block;\n  height: 3.3em;\n  margin-bottom: -2em;\n}\nform .option a {\n  display: inline-block;\n  float: left;\n  opacity: 1;\n  color: #6f879f;\n  font-size: .9em;\n  line-height: 3.66666667em;\n  text-align: center;\n  -webkit-transition: opacity 0.35s ease;\n  -moz-transition: opacity 0.35s ease;\n  -ms-transition: opacity 0.35s ease;\n  -o-transition: opacity 0.35s ease;\n}\nform .option a:hover {\n  opacity: .75;\n}\nform .option.single a {\n  width: 100%;\n}\nform .option.double a {\n  width: 50%;\n}\n.box {\n  overflow: hidden;\n  -webkit-border-radius: 9px;\n  -moz-border-radius: 9px;\n  border-radius: 9px;\n  -moz-background-clip: padding;\n  -webkit-background-clip: padding-box;\n  background-clip: padding-box;\n  border: 1px solid rgba(63, 95, 127, 0.03);\n  background-color: #f5f7f9;\n  -webkit-box-shadow: 0 0 15px 0 rgba(0, 0, 0, 0.05), 0 2px 1px 0px rgba(0, 0, 0, 0.075);\n  -moz-box-shadow: 0 0 15px 0 rgba(0, 0, 0, 0.05), 0 2px 1px 0px rgba(0, 0, 0, 0.075);\n  box-shadow: 0 0 15px 0 rgba(0, 0, 0, 0.05), 0 2px 1px 0px rgba(0, 0, 0, 0.075);\n}\n.box .header {\n  position: relative;\n  width: 100%;\n  height: 3.5em;\n  font-family: \"Rubik\";\n  font-weight: 500;\n  line-height: 3.5em;\n  text-align: center;\n  border-bottom: 2px solid rgba(63, 95, 127, 0.1);\n  background-color: white;\n}\n.box .header .title {\n  position: absolute;\n  top: 0;\n  right: 2.5em;\n  bottom: 0;\n  left: 2.5em;\n  width: auto;\n  color: #007fff;\n  font-size: 1.25em;\n  overflow: hidden;\n  text-overflow: ellipsis;\n  white-space: nowrap;\n}\n.box .header .option {\n  display: inline-block;\n  width: 3.5em;\n  height: 3.5em;\n  text-align: center;\n}\n.box .header .option svg path {\n  fill: #007fff;\n}\n.box .header .option:hover svg path {\n  fill: #198cff;\n}\n.box .header .option:active svg path {\n  fill: #0072e6;\n}\n.box .header .option.left {\n  float: left;\n}\n.box .header .option.right {\n  float: right;\n}\n.box .header .option svg {\n  position: relative;\n  top: -1px;\n  width: 1.75em;\n  height: 1.75em;\n  vertical-align: middle;\n  -webkit-transition: transform 0.35s ease;\n  -moz-transition: transform 0.35s ease;\n  -ms-transition: transform 0.35s ease;\n  -o-transition: transform 0.35s ease;\n}\n.box .header .option svg.new {\n  -webkit-transform: rotate(45deg);\n  -moz-transform: rotate(45deg);\n  -ms-transform: rotate(45deg);\n  -o-transform: rotate(45deg);\n}\n.box .header .option svg path {\n  fill: #007fff;\n  -webkit-transition: fill 0.35s ease;\n  -moz-transition: fill 0.35s ease;\n  -ms-transition: fill 0.35s ease;\n  -o-transition: fill 0.35s ease;\n}\n.box .header + .warning {\n  color: white;\n  border-bottom: none;\n}\n.box .header + .warning ul.fail {\n  background-color: #ff4f4f;\n}\n.box .header + .warning ul.success {\n  background-color: #00df5f;\n}\n.box .warning {\n  display: inline-block;\n  width: 100%;\n  padding: 0 5%;\n  text-align: center;\n  border-bottom: 1px solid rgba(63, 95, 127, 0.15);\n}\n.box .warning ul {\n  list-style: none;\n  width: 100%;\n  padding: 0 5%;\n}\n.box .warning ul.fail {\n  color: #ff4f4f;\n}\n.box .warning ul.success {\n  color: #00df5f;\n}\n.box .warning ul li {\n  margin-bottom: .1em;\n}\n.box .warning ul li:last-child {\n  margin-bottom: 0;\n}\n.box .content {\n  display: inline-block;\n  width: 100%;\n  padding: 2.5em;\n  background-color: #f5f7f9;\n}\n.box .content p {\n  margin: 0;\n  font-size: 14px;\n  line-height: 150%;\n}\n.card {\n  width: 15em;\n  text-align: center;\n  background-color: white;\n}\n.card .information {\n  height: 15em;\n}\n.card button {\n  width: 100%;\n  height: 3em;\n  -webkit-border-radius: 0;\n  -moz-border-radius: 0;\n  border-radius: 0;\n  -moz-background-clip: padding;\n  -webkit-background-clip: padding-box;\n  background-clip: padding-box;\n  color: white;\n  background-color: #007fff;\n}\n.card.color {\n  background-color: #007fff;\n}\n.card.color .option svg path {\n  fill: white;\n}\n.card.color .information a {\n  color: white;\n}\n.card.color .information a:hover {\n  color: #ffffff;\n}\n.card.color .information a:active {\n  color: #e6e6e6;\n}\n.card.color .information p {\n  color: rgba(255, 255, 255, 0.65);\n}\n.card.color button {\n  color: #007fff;\n  background-color: white;\n}\n.credit > * {\n  float: left;\n  height: 100%;\n}\n.credit img {\n  width: auto;\n  height: inherit;\n  border-radius: 50%;\n}\n.credit span {\n  -webkit-box-sizing: border-box;\n  -moz-box-sizing: border-box;\n  box-sizing: border-box;\n  display: inline-block;\n  height: inherit;\n  color: #007fff;\n  font-family: \"Rubik\";\n  font-weight: 700;\n}\n.credit span b {\n  display: block;\n  margin-bottom: .25em;\n  color: #007fff;\n  line-height: 100%;\n}\n.credit span small,\n.credit span time {\n  width: 100%;\n  color: #9fafbf;\n  line-height: 100%;\n  font-family: \"Rubik\";\n  font-weight: 400;\n}\n.credit span a {\n  color: #ff4f4f;\n  font-family: \"Rubik\";\n  font-weight: 400;\n}\n.credit span a:hover {\n  color: #ff6161;\n}\n.credit span a:active {\n  color: #e64747;\n}\n.credit span a::before {\n  content: '\\B7';\n  display: inline;\n  margin: 0 .25em;\n  color: #9fafbf;\n}\n.wallet {\n  display: block;\n  width: auto;\n  margin-top: .75em;\n  margin-left: -0.75em;\n  margin-right: -0.75em;\n}\n.wallet::after {\n  content: \"\";\n  display: table;\n  clear: both;\n}\n.wallet .content > * {\n  float: left;\n  margin: .75em;\n}\n.wallet .content > p {\n  display: block;\n  width: 100%;\n  margin-bottom: .75em;\n  color: white;\n  font-family: \"Rubik\";\n  font-weight: 500;\n  font-size: 1.25em;\n  text-align: center;\n}\n", ""]);

// exports


/***/ }),
/* 138 */
/***/ (function(module, exports) {

module.exports = function escape(url) {
    if (typeof url !== 'string') {
        return url
    }
    // If url is already wrapped in quotes, remove them
    if (/^['"].*['"]$/.test(url)) {
        url = url.slice(1, -1);
    }
    // Should url be wrapped?
    // See https://drafts.csswg.org/css-values-3/#urls
    if (/["'() \t\n]/.test(url)) {
        return '"' + url.replace(/"/g, '\\"').replace(/\n/g, '\\n') + '"'
    }

    return url
}


/***/ }),
/* 139 */
/***/ (function(module, exports) {

/*
	MIT License http://www.opensource.org/licenses/mit-license.php
	Author Tobias Koppers @sokra
*/
// css base code, injected by the css-loader
module.exports = function(useSourceMap) {
	var list = [];

	// return the list of modules as css string
	list.toString = function toString() {
		return this.map(function (item) {
			var content = cssWithMappingToString(item, useSourceMap);
			if(item[2]) {
				return "@media " + item[2] + "{" + content + "}";
			} else {
				return content;
			}
		}).join("");
	};

	// import a list of modules into the list
	list.i = function(modules, mediaQuery) {
		if(typeof modules === "string")
			modules = [[null, modules, ""]];
		var alreadyImportedModules = {};
		for(var i = 0; i < this.length; i++) {
			var id = this[i][0];
			if(typeof id === "number")
				alreadyImportedModules[id] = true;
		}
		for(i = 0; i < modules.length; i++) {
			var item = modules[i];
			// skip already imported module
			// this implementation is not 100% perfect for weird media query combinations
			//  when a module is imported multiple times with different media queries.
			//  I hope this will never occur (Hey this way we have smaller bundles)
			if(typeof item[0] !== "number" || !alreadyImportedModules[item[0]]) {
				if(mediaQuery && !item[2]) {
					item[2] = mediaQuery;
				} else if(mediaQuery) {
					item[2] = "(" + item[2] + ") and (" + mediaQuery + ")";
				}
				list.push(item);
			}
		}
	};
	return list;
};

function cssWithMappingToString(item, useSourceMap) {
	var content = item[1] || '';
	var cssMapping = item[3];
	if (!cssMapping) {
		return content;
	}

	if (useSourceMap && typeof btoa === 'function') {
		var sourceMapping = toComment(cssMapping);
		var sourceURLs = cssMapping.sources.map(function (source) {
			return '/*# sourceURL=' + cssMapping.sourceRoot + source + ' */'
		});

		return [content].concat(sourceURLs).concat([sourceMapping]).join('\n');
	}

	return [content].join('\n');
}

// Adapted from convert-source-map (MIT)
function toComment(sourceMap) {
	// eslint-disable-next-line no-undef
	var base64 = btoa(unescape(encodeURIComponent(JSON.stringify(sourceMap))));
	var data = 'sourceMappingURL=data:application/json;charset=utf-8;base64,' + base64;

	return '/*# ' + data + ' */';
}


/***/ }),
/* 140 */
/***/ (function(module, exports) {

module.exports = "data:font/woff;base64,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"

/***/ }),
/* 141 */
/***/ (function(module, exports) {

module.exports = "data:font/woff;base64,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"

/***/ }),
/* 142 */
/***/ (function(module, exports, __webpack_require__) {

/*
	MIT License http://www.opensource.org/licenses/mit-license.php
	Author Tobias Koppers @sokra
*/

var stylesInDom = {};

var	memoize = function (fn) {
	var memo;

	return function () {
		if (typeof memo === "undefined") memo = fn.apply(this, arguments);
		return memo;
	};
};

var isOldIE = memoize(function () {
	// Test for IE <= 9 as proposed by Browserhacks
	// @see http://browserhacks.com/#hack-e71d8692f65334173fee715c222cb805
	// Tests for existence of standard globals is to allow style-loader
	// to operate correctly into non-standard environments
	// @see https://github.com/webpack-contrib/style-loader/issues/177
	return window && document && document.all && !window.atob;
});

var getTarget = function (target) {
  return document.querySelector(target);
};

var getElement = (function (fn) {
	var memo = {};

	return function(target) {
                // If passing function in options, then use it for resolve "head" element.
                // Useful for Shadow Root style i.e
                // {
                //   insertInto: function () { return document.querySelector("#foo").shadowRoot }
                // }
                if (typeof target === 'function') {
                        return target();
                }
                if (typeof memo[target] === "undefined") {
			var styleTarget = getTarget.call(this, target);
			// Special case to return head of iframe instead of iframe itself
			if (window.HTMLIFrameElement && styleTarget instanceof window.HTMLIFrameElement) {
				try {
					// This will throw an exception if access to iframe is blocked
					// due to cross-origin restrictions
					styleTarget = styleTarget.contentDocument.head;
				} catch(e) {
					styleTarget = null;
				}
			}
			memo[target] = styleTarget;
		}
		return memo[target]
	};
})();

var singleton = null;
var	singletonCounter = 0;
var	stylesInsertedAtTop = [];

var	fixUrls = __webpack_require__(143);

module.exports = function(list, options) {
	if (typeof DEBUG !== "undefined" && DEBUG) {
		if (typeof document !== "object") throw new Error("The style-loader cannot be used in a non-browser environment");
	}

	options = options || {};

	options.attrs = typeof options.attrs === "object" ? options.attrs : {};

	// Force single-tag solution on IE6-9, which has a hard limit on the # of <style>
	// tags it will allow on a page
	if (!options.singleton && typeof options.singleton !== "boolean") options.singleton = isOldIE();

	// By default, add <style> tags to the <head> element
        if (!options.insertInto) options.insertInto = "head";

	// By default, add <style> tags to the bottom of the target
	if (!options.insertAt) options.insertAt = "bottom";

	var styles = listToStyles(list, options);

	addStylesToDom(styles, options);

	return function update (newList) {
		var mayRemove = [];

		for (var i = 0; i < styles.length; i++) {
			var item = styles[i];
			var domStyle = stylesInDom[item.id];

			domStyle.refs--;
			mayRemove.push(domStyle);
		}

		if(newList) {
			var newStyles = listToStyles(newList, options);
			addStylesToDom(newStyles, options);
		}

		for (var i = 0; i < mayRemove.length; i++) {
			var domStyle = mayRemove[i];

			if(domStyle.refs === 0) {
				for (var j = 0; j < domStyle.parts.length; j++) domStyle.parts[j]();

				delete stylesInDom[domStyle.id];
			}
		}
	};
};

function addStylesToDom (styles, options) {
	for (var i = 0; i < styles.length; i++) {
		var item = styles[i];
		var domStyle = stylesInDom[item.id];

		if(domStyle) {
			domStyle.refs++;

			for(var j = 0; j < domStyle.parts.length; j++) {
				domStyle.parts[j](item.parts[j]);
			}

			for(; j < item.parts.length; j++) {
				domStyle.parts.push(addStyle(item.parts[j], options));
			}
		} else {
			var parts = [];

			for(var j = 0; j < item.parts.length; j++) {
				parts.push(addStyle(item.parts[j], options));
			}

			stylesInDom[item.id] = {id: item.id, refs: 1, parts: parts};
		}
	}
}

function listToStyles (list, options) {
	var styles = [];
	var newStyles = {};

	for (var i = 0; i < list.length; i++) {
		var item = list[i];
		var id = options.base ? item[0] + options.base : item[0];
		var css = item[1];
		var media = item[2];
		var sourceMap = item[3];
		var part = {css: css, media: media, sourceMap: sourceMap};

		if(!newStyles[id]) styles.push(newStyles[id] = {id: id, parts: [part]});
		else newStyles[id].parts.push(part);
	}

	return styles;
}

function insertStyleElement (options, style) {
	var target = getElement(options.insertInto)

	if (!target) {
		throw new Error("Couldn't find a style target. This probably means that the value for the 'insertInto' parameter is invalid.");
	}

	var lastStyleElementInsertedAtTop = stylesInsertedAtTop[stylesInsertedAtTop.length - 1];

	if (options.insertAt === "top") {
		if (!lastStyleElementInsertedAtTop) {
			target.insertBefore(style, target.firstChild);
		} else if (lastStyleElementInsertedAtTop.nextSibling) {
			target.insertBefore(style, lastStyleElementInsertedAtTop.nextSibling);
		} else {
			target.appendChild(style);
		}
		stylesInsertedAtTop.push(style);
	} else if (options.insertAt === "bottom") {
		target.appendChild(style);
	} else if (typeof options.insertAt === "object" && options.insertAt.before) {
		var nextSibling = getElement(options.insertInto + " " + options.insertAt.before);
		target.insertBefore(style, nextSibling);
	} else {
		throw new Error("[Style Loader]\n\n Invalid value for parameter 'insertAt' ('options.insertAt') found.\n Must be 'top', 'bottom', or Object.\n (https://github.com/webpack-contrib/style-loader#insertat)\n");
	}
}

function removeStyleElement (style) {
	if (style.parentNode === null) return false;
	style.parentNode.removeChild(style);

	var idx = stylesInsertedAtTop.indexOf(style);
	if(idx >= 0) {
		stylesInsertedAtTop.splice(idx, 1);
	}
}

function createStyleElement (options) {
	var style = document.createElement("style");

	options.attrs.type = "text/css";

	addAttrs(style, options.attrs);
	insertStyleElement(options, style);

	return style;
}

function createLinkElement (options) {
	var link = document.createElement("link");

	options.attrs.type = "text/css";
	options.attrs.rel = "stylesheet";

	addAttrs(link, options.attrs);
	insertStyleElement(options, link);

	return link;
}

function addAttrs (el, attrs) {
	Object.keys(attrs).forEach(function (key) {
		el.setAttribute(key, attrs[key]);
	});
}

function addStyle (obj, options) {
	var style, update, remove, result;

	// If a transform function was defined, run it on the css
	if (options.transform && obj.css) {
	    result = options.transform(obj.css);

	    if (result) {
	    	// If transform returns a value, use that instead of the original css.
	    	// This allows running runtime transformations on the css.
	    	obj.css = result;
	    } else {
	    	// If the transform function returns a falsy value, don't add this css.
	    	// This allows conditional loading of css
	    	return function() {
	    		// noop
	    	};
	    }
	}

	if (options.singleton) {
		var styleIndex = singletonCounter++;

		style = singleton || (singleton = createStyleElement(options));

		update = applyToSingletonTag.bind(null, style, styleIndex, false);
		remove = applyToSingletonTag.bind(null, style, styleIndex, true);

	} else if (
		obj.sourceMap &&
		typeof URL === "function" &&
		typeof URL.createObjectURL === "function" &&
		typeof URL.revokeObjectURL === "function" &&
		typeof Blob === "function" &&
		typeof btoa === "function"
	) {
		style = createLinkElement(options);
		update = updateLink.bind(null, style, options);
		remove = function () {
			removeStyleElement(style);

			if(style.href) URL.revokeObjectURL(style.href);
		};
	} else {
		style = createStyleElement(options);
		update = applyToTag.bind(null, style);
		remove = function () {
			removeStyleElement(style);
		};
	}

	update(obj);

	return function updateStyle (newObj) {
		if (newObj) {
			if (
				newObj.css === obj.css &&
				newObj.media === obj.media &&
				newObj.sourceMap === obj.sourceMap
			) {
				return;
			}

			update(obj = newObj);
		} else {
			remove();
		}
	};
}

var replaceText = (function () {
	var textStore = [];

	return function (index, replacement) {
		textStore[index] = replacement;

		return textStore.filter(Boolean).join('\n');
	};
})();

function applyToSingletonTag (style, index, remove, obj) {
	var css = remove ? "" : obj.css;

	if (style.styleSheet) {
		style.styleSheet.cssText = replaceText(index, css);
	} else {
		var cssNode = document.createTextNode(css);
		var childNodes = style.childNodes;

		if (childNodes[index]) style.removeChild(childNodes[index]);

		if (childNodes.length) {
			style.insertBefore(cssNode, childNodes[index]);
		} else {
			style.appendChild(cssNode);
		}
	}
}

function applyToTag (style, obj) {
	var css = obj.css;
	var media = obj.media;

	if(media) {
		style.setAttribute("media", media)
	}

	if(style.styleSheet) {
		style.styleSheet.cssText = css;
	} else {
		while(style.firstChild) {
			style.removeChild(style.firstChild);
		}

		style.appendChild(document.createTextNode(css));
	}
}

function updateLink (link, options, obj) {
	var css = obj.css;
	var sourceMap = obj.sourceMap;

	/*
		If convertToAbsoluteUrls isn't defined, but sourcemaps are enabled
		and there is no publicPath defined then lets turn convertToAbsoluteUrls
		on by default.  Otherwise default to the convertToAbsoluteUrls option
		directly
	*/
	var autoFixUrls = options.convertToAbsoluteUrls === undefined && sourceMap;

	if (options.convertToAbsoluteUrls || autoFixUrls) {
		css = fixUrls(css);
	}

	if (sourceMap) {
		// http://stackoverflow.com/a/26603875
		css += "\n/*# sourceMappingURL=data:application/json;base64," + btoa(unescape(encodeURIComponent(JSON.stringify(sourceMap)))) + " */";
	}

	var blob = new Blob([css], { type: "text/css" });

	var oldSrc = link.href;

	link.href = URL.createObjectURL(blob);

	if(oldSrc) URL.revokeObjectURL(oldSrc);
}


/***/ }),
/* 143 */
/***/ (function(module, exports) {


/**
 * When source maps are enabled, `style-loader` uses a link element with a data-uri to
 * embed the css on the page. This breaks all relative urls because now they are relative to a
 * bundle instead of the current page.
 *
 * One solution is to only use full urls, but that may be impossible.
 *
 * Instead, this function "fixes" the relative urls to be absolute according to the current page location.
 *
 * A rudimentary test suite is located at `test/fixUrls.js` and can be run via the `npm test` command.
 *
 */

module.exports = function (css) {
  // get current location
  var location = typeof window !== "undefined" && window.location;

  if (!location) {
    throw new Error("fixUrls requires window.location");
  }

	// blank or null?
	if (!css || typeof css !== "string") {
	  return css;
  }

  var baseUrl = location.protocol + "//" + location.host;
  var currentDir = baseUrl + location.pathname.replace(/\/[^\/]*$/, "/");

	// convert each url(...)
	/*
	This regular expression is just a way to recursively match brackets within
	a string.

	 /url\s*\(  = Match on the word "url" with any whitespace after it and then a parens
	   (  = Start a capturing group
	     (?:  = Start a non-capturing group
	         [^)(]  = Match anything that isn't a parentheses
	         |  = OR
	         \(  = Match a start parentheses
	             (?:  = Start another non-capturing groups
	                 [^)(]+  = Match anything that isn't a parentheses
	                 |  = OR
	                 \(  = Match a start parentheses
	                     [^)(]*  = Match anything that isn't a parentheses
	                 \)  = Match a end parentheses
	             )  = End Group
              *\) = Match anything and then a close parens
          )  = Close non-capturing group
          *  = Match anything
       )  = Close capturing group
	 \)  = Match a close parens

	 /gi  = Get all matches, not the first.  Be case insensitive.
	 */
	var fixedCss = css.replace(/url\s*\(((?:[^)(]|\((?:[^)(]+|\([^)(]*\))*\))*)\)/gi, function(fullMatch, origUrl) {
		// strip quotes (if they exist)
		var unquotedOrigUrl = origUrl
			.trim()
			.replace(/^"(.*)"$/, function(o, $1){ return $1; })
			.replace(/^'(.*)'$/, function(o, $1){ return $1; });

		// already a full url? no change
		if (/^(#|data:|http:\/\/|https:\/\/|file:\/\/\/|\s*$)/i.test(unquotedOrigUrl)) {
		  return fullMatch;
		}

		// convert the url to a full url
		var newUrl;

		if (unquotedOrigUrl.indexOf("//") === 0) {
		  	//TODO: should we add protocol?
			newUrl = unquotedOrigUrl;
		} else if (unquotedOrigUrl.indexOf("/") === 0) {
			// path should be relative to the base url
			newUrl = baseUrl + unquotedOrigUrl; // already starts with '/'
		} else {
			// path should be relative to current directory
			newUrl = currentDir + unquotedOrigUrl.replace(/^\.\//, ""); // Strip leading './'
		}

		// send back the fixed url(...)
		return "url(" + JSON.stringify(newUrl) + ")";
	});

	// send back the fixed css
	return fixedCss;
};


/***/ }),
/* 144 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


Object.defineProperty(exports, "__esModule", {
	value: true
});

exports.default = function () {
	var args = Array.from(arguments);
	var callback = args.pop();
	createGroupCall(args, callback);
};

var _api = __webpack_require__(1);

var _api2 = _interopRequireDefault(_api);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function createGroupCall(args, callback) {
	(0, _api2.default)("createGroup", {
		"title": args[0],
		"description": args[1]
	}, function (response) {
		callback(response);
	});
};

;

/***/ }),
/* 145 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


Object.defineProperty(exports, "__esModule", {
	value: true
});

exports.default = function (callback) {
	listGroupsCall(callback);
};

var _api = __webpack_require__(1);

var _api2 = _interopRequireDefault(_api);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function listGroupsCall(callback) {
	(0, _api2.default)("listGroups", {}, function (response) {
		callback(response.data);
	});
};

;

/***/ }),
/* 146 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


Object.defineProperty(exports, "__esModule", {
	value: true
});

exports.default = function () {
	var args = Array.from(arguments);
	var callback = args.pop();
	unfollowCall(args, callback);
};

var _api = __webpack_require__(1);

var _api2 = _interopRequireDefault(_api);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function unfollowCall(args, callback) {
	(0, _api2.default)("unfollow", {
		"id": args[0]
	}, function (response) {
		callback(response.data);
	});
};

;

/***/ }),
/* 147 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


Object.defineProperty(exports, "__esModule", {
	value: true
});

exports.default = function () {
	countUnreadMessagesCall();
};

var _api = __webpack_require__(1);

var _api2 = _interopRequireDefault(_api);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function countUnreadMessagesCall(callback) {
	(0, _api2.default)("countUnreadMessages", {}, function (response) {
		callback(response.data);
	});
};

;

/***/ }),
/* 148 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


Object.defineProperty(exports, "__esModule", {
	value: true
});

exports.default = function (callback) {
	getInboxCall(callback);
};

var _api = __webpack_require__(1);

var _api2 = _interopRequireDefault(_api);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function getInboxCall(callback) {
	(0, _api2.default)("getInbox", {}, function (response) {
		callback(response.data);
	});
};

;

/***/ }),
/* 149 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


Object.defineProperty(exports, "__esModule", {
	value: true
});

exports.default = function () {
	var args = Array.from(arguments);
	var callback = args.pop();
	getMessageCall(args, callback);
};

var _api = __webpack_require__(1);

var _api2 = _interopRequireDefault(_api);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function getMessageCall(args, callback) {
	(0, _api2.default)("getMessage", {
		"msgid": args[0]
	}, function (response) {
		callback(response.data);
	});
};

;

/***/ }),
/* 150 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


Object.defineProperty(exports, "__esModule", {
	value: true
});

exports.default = function () {
	getOutboxCall();
};

var _api = __webpack_require__(1);

var _api2 = _interopRequireDefault(_api);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function getOutboxCall(callback) {
	(0, _api2.default)("getOutbox", {}, function (response) {
		callback(response.data);
	});
};

;

/***/ })
/******/ ]);