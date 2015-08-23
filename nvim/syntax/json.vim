" Vim syntax file
" Language: JSON
" Last Change:  2014-12-20 Load ftplugin/json.vim

if exists("b:current_syntax")
  finish
endif

syntax match   jsonNoise           /\%(:\|,\)/

" NOTE that for the concealing to work your conceallevel should be set to 2

" Separated into a match and region because a region by itself is always greedy
syn match  jsonStringMatch /"\([^"]\|\\\"\)\+"\ze[[:blank:]\r\n]*[,}\]]/ contains=jsonString
syn region  jsonString oneline matchgroup=jsonQuote start=/"/  skip=/\\\\\|\\"/  end=/"/ contains=jsonEscape contained

" Syntax: JSON does not allow strings with single quotes, unlike JavaScript.
syn region  jsonStringSQError oneline  start=+'+  skip=+\\\\\|\\"+  end=+'+

" Syntax: JSON Keywords
" Separated into a match and region because a region by itself is always greedy
syn match  jsonKeywordMatch /"\([^"]\|\\\"\)\+"[[:blank:]\r\n]*\:/ contains=jsonKeyword
syn region  jsonKeyword matchgroup=jsonQuote start=/"/  end=/"\ze[[:blank:]\r\n]*\:/ contains=jsonEscape contained

" Syntax: Escape sequences
syn match   jsonEscape    "\\["\\/bfnrt]" contained
syn match   jsonEscape    "\\u\x\{4}" contained

" Syntax: Numbers
syn match   jsonNumber    "-\=\<\%(0\|[1-9]\d*\)\%(\.\d\+\)\=\%([eE][-+]\=\d\+\)\=\>\ze[[:blank:]\r\n]*[,}\]]"

syn match  jsonPadding "\%^[[:blank:]\r\n]*[_$[:alpha:]][_$[:alnum:]]*[[:blank:]\r\n]*("
syn match  jsonPadding ");[[:blank:]\r\n]*\%$"

" Syntax: Boolean
syn match  jsonBoolean /\(true\|false\)\(\_s\+\ze"\)\@!/

" Syntax: Null
syn keyword  jsonNull      null

" Syntax: Braces
syn region  jsonFold matchgroup=jsonBraces start="{" end=/}\(\_s\+\ze\("\|{\)\)\@!/ transparent fold
syn region  jsonFold matchgroup=jsonBraces start="\[" end=/]\(\_s\+\ze"\)\@!/ transparent fold

" Define the default highlighting.
if version >= 508 || !exists("did_json_syn_inits")
  hi def link jsonPadding       Operator
  hi def link jsonString        String
  hi def link jsonTest          Label
  hi def link jsonEscape        Special
  hi def link jsonNumber        Delimiter
  hi def link jsonBraces        Delimiter
  hi def link jsonNull          Function
  hi def link jsonBoolean       Delimiter
  hi def link jsonKeyword       Label

  hi def link jsonQuote         Quote
  hi def link jsonNoise         Noise
endif

let b:current_syntax = "json"
