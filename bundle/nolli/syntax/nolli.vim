" Vim syntax file
" Language:     Nolli
" Maintainer:   Joe Naegele <joseph.naegele@gmail.com>
" Last Change:  2013-09-21

" Quit when a (custom) syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

syn keyword nolliStatement       pass break continue return
syn keyword nolliStatement       func nextgroup=nolliFunction skipwhite
syn keyword nolliConditional     if else
syn keyword nolliRepeat          for while until do
syn keyword nolliOperator        in is and or not module
" syn keyword nolliException     except finally raise try
" syn keyword nolliInclude       from import

syn keyword nolliFunction        func class

syn keyword nolliTodo            FIXME NOTE NOTES TODO XXX contained
syn match   nolliComment "//.*$" contains=nolliTodo,@Spell
syn region  nolliComment start="/\*" end="\*/" contains=nolliTodo,@Spell

syn match   nolliCurlyError "}"
syn region  nolliBlock start="{" end="}" contains=ALLBUT,nolliCurlyError fold

" Triple-quoted strings can contain doctests.
syn region  nolliString
      \ start=+[uU]\=\z(["]\)+ end="\z1" skip="\\\\\|\\\z1"
      \ contains=nolliEscape,@Spell
syn region  nolliRawString
      \ start=+[uU]\=[rR]\z(["]\)+ end="\z1" skip="\\\\\|\\\z1"
      \ contains=@Spell

syn match   nolliEscape  +\\[abfnrtv'"\\]+ contained
syn match   nolliEscape  "\\\o\{1,3}" contained
syn match   nolliEscape  "\\x\x\{2}" contained
syn match   nolliEscape  "\%(\\u\x\{4}\|\\U\x\{8}\)" contained
" Python allows case-insensitive Unicode IDs: http://www.unicode.org/charts/
syn match   nolliEscape  "\\N{\a\+\%(\s\a\+\)*}" contained
syn match   nolliEscape  "\\$"

" It is very important to understand all details before changing the
" regular expressions below or their order.
" The word boundaries are *not* the floating-point number boundaries
" because of a possible leading or trailing decimal point.
" The expressions below ensure that all valid number literals are
" highlighted, and invalid number literals are not.  For example,
"
" - a decimal point in '4.' at the end of a line is highlighted,
" - a second dot in 1.0.0 is not highlighted,
" - 08 is not highlighted,
" - 08e0 or 08j are highlighted,
"
" and so on, as specified in the 'Python Language Reference'.
" http://docs.nolli.org/reference/lexical_analysis.html#numeric-literals
" numbers (including longs and complex)
syn match   nolliNumber        "\<0[oO]\=\o\+[Ll]\=\>"
syn match   nolliNumber        "\<0[xX]\x\+[Ll]\=\>"
syn match   nolliNumber        "\<0[bB][01]\+[Ll]\=\>"
syn match   nolliNumber        "\<\%([1-9]\d*\|0\)[Ll]\=\>"
syn match   nolliNumber        "\<\d\+[jJ]\>"
syn match   nolliNumber        "\<\d\+[eE][+-]\=\d\+[jJ]\=\>"
syn match   nolliNumber
      \ "\<\d\+\.\%([eE][+-]\=\d\+\)\=[jJ]\=\%(\W\|$\)\@="
syn match   nolliNumber
      \ "\%(^\|\W\)\@<=\d*\.\d\+\%([eE][+-]\=\d\+\)\=[jJ]\=\>"

" Group the built-ins in the order in the 'Python Library Reference' for
" easier comparison.
" Python built-in functions are in alphabetical order.

" contants
syn keyword nolliConstant    true false nil
syn keyword nolliConstant    stdout stderr stdin

" built-in functions
syn keyword nolliBuiltin     typeof typedef
syn keyword nolliBuiltin     bool char int real str list map file
syn keyword nolliBuiltin     exit
syn keyword nolliBuiltin     print
syn keyword nolliBuiltin     assert
syn keyword nolliBuiltin     fopen fclose fread fwrite
syn keyword nolliBuiltin     input
syn keyword nolliBuiltin     range
"syn keyword nolliBuiltin     len sum max min
"syn keyword nolliBuiltin     abs
"syn keyword nolliBuiltin     round
"syn keyword nolliBuiltin     divmod
"syn keyword nolliBuiltin     del
"syn keyword nolliBuiltin     hash
"syn keyword nolliBuiltin     chr ord
"syn keyword nolliBuiltin     reversed sorted
"syn keyword nolliBuiltin     zip

"syn keyword nolliExceptions    Exception

" Sync at the beginning of class, function, or method definition.
syn sync match nolliSync grouphere NONE "^\s*\%(func\|class\)\s\+\h\w*\s*("

" The default highlight links.  Can be overridden later.
hi def link nolliStatement       Statement
hi def link nolliConditional     Conditional
hi def link nolliRepeat          Repeat
hi def link nolliOperator        Operator
hi def link nolliException       Exception
hi def link nolliInclude         Include
hi def link nolliFunction        Function
hi def link nolliComment         Comment
hi def link nolliTodo            Todo
hi def link nolliString          String
hi def link nolliRawString       String
hi def link nolliEscape          Special
hi def link nolliNumber          Number
hi def link nolliBuiltin         Define
hi def link nolliConstant        Special
hi def link nolliExceptions      Structure
hi def link nolliCurlyError      Error

let b:current_syntax = "nolli"

" vim:set sw=4 sts=4 et:
