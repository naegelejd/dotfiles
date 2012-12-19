" Vim syntax file
" Language:     Luci
" Maintainer:   Joe Naegele <joseph.naegele@gmail.com>
" Last Change:  2012-09-16

" For version 5.x: Clear all syntax items.
" For version 6.x: Quit when a syntax file was already loaded.
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

"
syn keyword luciStatement       False, None, True
syn keyword luciStatement       return
"syn keyword luciStatement       as assert break continue del exec global
"syn keyword luciStatement       lambda nonlocal pass print return with yield
syn keyword luciStatement       def nextgroup=luciFunction skipwhite
syn keyword luciConditional     if then else end
syn keyword luciRepeat          for in while do done
"syn keyword luciOperator        in
"syn keyword luciOperator        and in is not or
" syn keyword luciException       except finally raise try
" syn keyword luciInclude         from import

" The zero-length non-grouping match before the function name is
" extremely important in luciFunction.  Without it, everything is
" interpreted as a function inside the contained environment of
" doctests.
" A dot must be allowed because of @MyClass.myfunc decorators.
syn match   luciFunction
      \ "\%(\%(def\s\)\s*\)\@<=\h\%(\w\|\.\)*" contained

syn match   luciComment "#.*$" contains=luciTodo,@Spell
syn keyword luciTodo            FIXME NOTE NOTES TODO XXX contained

" Triple-quoted strings can contain doctests.
syn region  luciString
      \ start=+[uU]\=\z(["]\)+ end="\z1" skip="\\\\\|\\\z1"
      \ contains=luciEscape,@Spell
syn region  luciRawString
      \ start=+[uU]\=[rR]\z(["]\)+ end="\z1" skip="\\\\\|\\\z1"
      \ contains=@Spell

syn match   luciEscape  +\\[abfnrtv'"\\]+ contained
syn match   luciEscape  "\\\o\{1,3}" contained
syn match   luciEscape  "\\x\x\{2}" contained
syn match   luciEscape  "\%(\\u\x\{4}\|\\U\x\{8}\)" contained
" Python allows case-insensitive Unicode IDs: http://www.unicode.org/charts/
syn match   luciEscape  "\\N{\a\+\%(\s\a\+\)*}" contained
syn match   luciEscape  "\\$"

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
" http://docs.luci.org/reference/lexical_analysis.html#numeric-literals
" numbers (including longs and complex)
syn match   luciNumber        "\<0[oO]\=\o\+[Ll]\=\>"
syn match   luciNumber        "\<0[xX]\x\+[Ll]\=\>"
syn match   luciNumber        "\<0[bB][01]\+[Ll]\=\>"
syn match   luciNumber        "\<\%([1-9]\d*\|0\)[Ll]\=\>"
syn match   luciNumber        "\<\d\+[jJ]\>"
syn match   luciNumber        "\<\d\+[eE][+-]\=\d\+[jJ]\=\>"
syn match   luciNumber
      \ "\<\d\+\.\%([eE][+-]\=\d\+\)\=[jJ]\=\%(\W\|$\)\@="
syn match   luciNumber
      \ "\%(^\|\W\)\@<=\d*\.\d\+\%([eE][+-]\=\d\+\)\=[jJ]\=\>"

" Group the built-ins in the order in the 'Python Library Reference' for
" easier comparison.
" Python built-in functions are in alphabetical order.

" built-in constants
" 'False', 'True', and 'None' are also reserved words in Python 3.0
syn keyword luciBuiltin       False True None
" built-in functions
syn keyword luciBuiltin     help
syn keyword luciBuiltin     print
syn keyword luciBuiltin     input
syn keyword luciBuiltin     readline
syn keyword luciBuiltin     type
syn keyword luciBuiltin     assert
syn keyword luciBuiltin     str
syn keyword luciBuiltin     int
syn keyword luciBuiltin     float
syn keyword luciBuiltin     open
syn keyword luciBuiltin     close
syn keyword luciBuiltin     read
syn keyword luciBuiltin     write
syn keyword luciBuiltin     readlines
syn keyword luciBuiltin     range
syn keyword luciBuiltin     sum

"syn keyword luciBuiltin       abs all any bin bool chr classmethod
"syn keyword luciBuiltin       abs all any bin bool chr classmethod
"syn keyword luciBuiltin       compile complex delattr dict dir divmod
"syn keyword luciBuiltin       enumerate eval filter float format
"syn keyword luciBuiltin       frozenset getattr globals hasattr hash
"syn keyword luciBuiltin       help hex id input int isinstance
"syn keyword luciBuiltin       issubclass iter len list locals map max
"syn keyword luciBuiltin       min next object oct open ord pow print
"syn keyword luciBuiltin       property range repr reversed round set
"syn keyword luciBuiltin       setattr slice sorted staticmethod str
"syn keyword luciBuiltin       sum super tuple type vars zip __import__

" builtin base exceptions (only used as base classes for other exceptions)
syn keyword luciExceptions    BaseException Exception
syn keyword luciExceptions    ArithmeticError EnvironmentError
syn keyword luciExceptions    LookupError


" Sync at the beginning of class, function, or method definition.
syn sync match luciSync grouphere NONE "^\s*\%(def\|class\)\s\+\h\w*\s*("

if version >= 508
  command -nargs=+ HiLink hi def link <args>
else
  command -nargs=+ HiLink hi link <args>
endif

" The default highlight links.  Can be overridden later.
HiLink luciStatement        Statement
HiLink luciConditional      Conditional
HiLink luciRepeat           Repeat
HiLink luciOperator         Operator
HiLink luciException        Exception
HiLink luciInclude          Include
HiLink luciDecorator        Define
HiLink luciFunction         Function
HiLink luciComment          Comment
HiLink luciTodo             Todo
HiLink luciString           String
HiLink luciRawString        String
HiLink luciEscape           Special
HiLink luciNumber           Number
HiLink luciBuiltin          Function
HiLink luciExceptions       Structure

delcommand HiLink

let b:current_syntax = "luci"

" vim:set sw=2 sts=2 ts=8 noet:
