" Language:     Lemon Parser Generator
" Maintainer:   dccmx <dccmx@dccmx.com>
" URL:          http://github.com/dccmx/vim-lemon-syntax
" License:      MIT

if exists("b:current_syntax")
  finish
endif

if version < 600
  syntax clear
endif

" A bunch of useful C keywords
syn keyword     cStatement      goto break return continue asm
syn keyword     cLabel          case default
syn keyword     cConditional    if else switch
syn keyword     cRepeat         while for do

syn keyword     cTodo           contained TODO FIXME XXX

syn keyword     cOperator       sizeof
if exists("c_gnu")
  syn keyword   cStatement      __asm__
  syn keyword   cOperator       typeof __real__ __imag__
endif
syn keyword     cType           int long short char void
syn keyword     cType           signed unsigned float double
if !exists("c_no_ansi") || exists("c_ansi_typedefs")
  syn keyword   cType           size_t ssize_t off_t wchar_t ptrdiff_t sig_atomic_t fpos_t
  syn keyword   cType           clock_t time_t va_list jmp_buf FILE DIR div_t ldiv_t
  syn keyword   cType           mbstate_t wctrans_t wint_t wctype_t
endif
if !exists("c_no_c99") " ISO C99
  syn keyword   cType           bool complex
  syn keyword   cType           int8_t int16_t int32_t int64_t
  syn keyword   cType           uint8_t uint16_t uint32_t uint64_t
  syn keyword   cType           int_least8_t int_least16_t int_least32_t int_least64_t
  syn keyword   cType           uint_least8_t uint_least16_t uint_least32_t uint_least64_t
  syn keyword   cType           int_fast8_t int_fast16_t int_fast32_t int_fast64_t
  syn keyword   cType           uint_fast8_t uint_fast16_t uint_fast32_t uint_fast64_t
  syn keyword   cType           intptr_t uintptr_t
  syn keyword   cType           intmax_t uintmax_t
endif
if exists("c_gnu")
  syn keyword   cType           __label__ __complex__ __volatile__
endif

syn keyword     cStructure      struct union enum typedef
syn keyword     cStorageClass   static register auto volatile extern const
if exists("c_gnu")
  syn keyword   cStorageClass   inline __attribute__
endif
if !exists("c_no_c99")
  syn keyword   cStorageClass   inline restrict
endif

if !exists("c_no_ansi") || exists("c_ansi_constants") || exists("c_gnu")
  if exists("c_gnu")
    syn keyword cConstant __GNUC__ __FUNCTION__ __PRETTY_FUNCTION__ __func__
  endif
  syn keyword cConstant __LINE__ __FILE__ __DATE__ __TIME__ __STDC__
  syn keyword cConstant __STDC_VERSION__
  syn keyword cConstant CHAR_BIT MB_LEN_MAX MB_CUR_MAX
  syn keyword cConstant UCHAR_MAX UINT_MAX ULONG_MAX USHRT_MAX
  syn keyword cConstant CHAR_MIN INT_MIN LONG_MIN SHRT_MIN
  syn keyword cConstant CHAR_MAX INT_MAX LONG_MAX SHRT_MAX
  syn keyword cConstant SCHAR_MIN SINT_MIN SLONG_MIN SSHRT_MIN
  syn keyword cConstant SCHAR_MAX SINT_MAX SLONG_MAX SSHRT_MAX
  if !exists("c_no_c99")
    syn keyword cConstant __func__
    syn keyword cConstant LLONG_MIN LLONG_MAX ULLONG_MAX
    syn keyword cConstant INT8_MIN INT16_MIN INT32_MIN INT64_MIN
    syn keyword cConstant INT8_MAX INT16_MAX INT32_MAX INT64_MAX
    syn keyword cConstant UINT8_MAX UINT16_MAX UINT32_MAX UINT64_MAX
    syn keyword cConstant INT_LEAST8_MIN INT_LEAST16_MIN INT_LEAST32_MIN INT_LEAST64_MIN
    syn keyword cConstant INT_LEAST8_MAX INT_LEAST16_MAX INT_LEAST32_MAX INT_LEAST64_MAX
    syn keyword cConstant UINT_LEAST8_MAX UINT_LEAST16_MAX UINT_LEAST32_MAX UINT_LEAST64_MAX
    syn keyword cConstant INT_FAST8_MIN INT_FAST16_MIN INT_FAST32_MIN INT_FAST64_MIN
    syn keyword cConstant INT_FAST8_MAX INT_FAST16_MAX INT_FAST32_MAX INT_FAST64_MAX
    syn keyword cConstant UINT_FAST8_MAX UINT_FAST16_MAX UINT_FAST32_MAX UINT_FAST64_MAX
    syn keyword cConstant INTPTR_MIN INTPTR_MAX UINTPTR_MAX
    syn keyword cConstant INTMAX_MIN INTMAX_MAX UINTMAX_MAX
    syn keyword cConstant PTRDIFF_MIN PTRDIFF_MAX SIG_ATOMIC_MIN SIG_ATOMIC_MAX
    syn keyword cConstant SIZE_MAX WCHAR_MIN WCHAR_MAX WINT_MIN WINT_MAX
  endif
  syn keyword cConstant FLT_RADIX FLT_ROUNDS
  syn keyword cConstant FLT_DIG FLT_MANT_DIG FLT_EPSILON
  syn keyword cConstant DBL_DIG DBL_MANT_DIG DBL_EPSILON
  syn keyword cConstant LDBL_DIG LDBL_MANT_DIG LDBL_EPSILON
  syn keyword cConstant FLT_MIN FLT_MAX FLT_MIN_EXP FLT_MAX_EXP
  syn keyword cConstant FLT_MIN_10_EXP FLT_MAX_10_EXP
  syn keyword cConstant DBL_MIN DBL_MAX DBL_MIN_EXP DBL_MAX_EXP
  syn keyword cConstant DBL_MIN_10_EXP DBL_MAX_10_EXP
  syn keyword cConstant LDBL_MIN LDBL_MAX LDBL_MIN_EXP LDBL_MAX_EXP
  syn keyword cConstant LDBL_MIN_10_EXP LDBL_MAX_10_EXP
  syn keyword cConstant HUGE_VAL CLOCKS_PER_SEC NULL
  syn keyword cConstant LC_ALL LC_COLLATE LC_CTYPE LC_MONETARY
  syn keyword cConstant LC_NUMERIC LC_TIME
  syn keyword cConstant SIG_DFL SIG_ERR SIG_IGN
  syn keyword cConstant SIGABRT SIGFPE SIGILL SIGHUP SIGINT SIGSEGV SIGTERM
  " Add POSIX signals as well...
  syn keyword cConstant SIGABRT SIGALRM SIGCHLD SIGCONT SIGFPE SIGHUP
  syn keyword cConstant SIGILL SIGINT SIGKILL SIGPIPE SIGQUIT SIGSEGV
  syn keyword cConstant SIGSTOP SIGTERM SIGTRAP SIGTSTP SIGTTIN SIGTTOU
  syn keyword cConstant SIGUSR1 SIGUSR2
  syn keyword cConstant _IOFBF _IOLBF _IONBF BUFSIZ EOF WEOF
  syn keyword cConstant FOPEN_MAX FILENAME_MAX L_tmpnam
  syn keyword cConstant SEEK_CUR SEEK_END SEEK_SET
  syn keyword cConstant TMP_MAX stderr stdin stdout
  syn keyword cConstant EXIT_FAILURE EXIT_SUCCESS RAND_MAX
  " Add POSIX errors as well
  syn keyword cConstant E2BIG EACCES EAGAIN EBADF EBADMSG EBUSY
  syn keyword cConstant ECANCELED ECHILD EDEADLK EDOM EEXIST EFAULT
  syn keyword cConstant EFBIG EILSEQ EINPROGRESS EINTR EINVAL EIO EISDIR
  syn keyword cConstant EMFILE EMLINK EMSGSIZE ENAMETOOLONG ENFILE ENODEV
  syn keyword cConstant ENOENT ENOEXEC ENOLCK ENOMEM ENOSPC ENOSYS
  syn keyword cConstant ENOTDIR ENOTEMPTY ENOTSUP ENOTTY ENXIO EPERM
  syn keyword cConstant EPIPE ERANGE EROFS ESPIPE ESRCH ETIMEDOUT EXDEV
  " math.h
  syn keyword cConstant M_E M_LOG2E M_LOG10E M_LN2 M_LN10 M_PI M_PI_2 M_PI_4
  syn keyword cConstant M_1_PI M_2_PI M_2_SQRTPI M_SQRT2 M_SQRT1_2
endif
if !exists("c_no_c99") " ISO C99
  syn keyword cConstant true false
endif


" String and Character constants
" Highlight special characters (those which have a backslash) differently
syn match       cSpecial        display contained "\\\(x\x\+\|\o\{1,3}\|.\|$\)"
if !exists("c_no_utf")
  syn match     cSpecial        display contained "\\\(u\x\{4}\|U\x\{8}\)"
endif
if exists("c_no_cformat")
  syn region    cString         start=+L\="+ skip=+\\\\\|\\"+ end=+"+ contains=cSpecial,@Spell
  " cCppString: same as cString, but ends at end of line
  syn region    cCppString      start=+L\="+ skip=+\\\\\|\\"\|\\$+ excludenl end=+"+ end='$' contains=cSpecial,@Spell
else
  if !exists("c_no_c99") " ISO C99
    syn match   cFormat         display "%\(\d\+\$\)\=[-+' #0*]*\(\d*\|\*\|\*\d\+\$\)\(\.\(\d*\|\*\|\*\d\+\$\)\)\=\([hlLjzt]\|ll\|hh\)\=\([aAbdiuoxXDOUfFeEgGcCsSpn]\|\[\^\=.[^]]*\]\)" contained
  else
    syn match   cFormat         display "%\(\d\+\$\)\=[-+' #0*]*\(\d*\|\*\|\*\d\+\$\)\(\.\(\d*\|\*\|\*\d\+\$\)\)\=\([hlL]\|ll\)\=\([bdiuoxXDOUfeEgGcCsSpn]\|\[\^\=.[^]]*\]\)" contained
  endif
  syn match     cFormat         display "%%" contained
  syn region    cString         start=+L\="+ skip=+\\\\\|\\"+ end=+"+ contains=cSpecial,cFormat,@Spell
  " cCppString: same as cString, but ends at end of line
  syn region    cCppString      start=+L\="+ skip=+\\\\\|\\"\|\\$+ excludenl end=+"+ end='$' contains=cSpecial,cFormat,@Spell
endif

syn match       cCharacter      "L\='[^\\]'"
syn match       cCharacter      "L'[^']*'" contains=cSpecial
if exists("c_gnu")
  syn match     cSpecialError   "L\='\\[^'\"?\\abefnrtv]'"
  syn match     cSpecialCharacter "L\='\\['\"?\\abefnrtv]'"
else
  syn match     cSpecialError   "L\='\\[^'\"?\\abfnrtv]'"
  syn match     cSpecialCharacter "L\='\\['\"?\\abfnrtv]'"
endif
syn match       cSpecialCharacter display "L\='\\\o\{1,3}'"
syn match       cSpecialCharacter display "'\\x\x\{1,2}'"
syn match       cSpecialCharacter display "L'\\x\x\+'"


syn match   lemonAssign           /<::=>/

" Comments; their contents
syn region  lemonComment          start="/\*" end="\*/" contains=cTodo
syn region  lemonComment          start="//" end="$" contains=cTodo
syn cluster cStringGroup          contains=cString,cCharacter,cCppString,cSpecial,cFormat,cSpecialError,cSpecialCharacter
syn cluster cGroup                contains=cStatement,cLabel,cConditional,cRepeat,cTodo,cConstant,cType,cOperator,cStructure,cStorageClass
syn region  lemonCode             start="{" end="}" fold contains=lemonComment,@cGroup,@cStringGroup
syn match   lemonInclude          /#.\+/
syn match   lemonDirective        /^%\(\w\|_\)\+\>.\+/ contains=lemonDirectiveArg
syn match   lemonDirectiveArg     /\s.\+$/ contained
syn match   lemonNonTerminal      /\<\l\w\+\>/
syn match   lemonTerminal         /\<\u\w\+\>/
syn match   lemonID               /(\w)/

hi def link cStatement            Keyword
hi def link cLabel                Keyword
hi def link cConditional          Keyword
hi def link cRepeat               Keyword
hi def link cTodo                 Todo
hi def link lemonAssign           SpecialChar
" hi def link lemonCode             String
hi def link cString               String
hi def link cCharactor            Charactor
hi def link lemonID               Identifier
hi def link lemonInclude          Include
hi def link lemonComment          Comment
hi def link lemonDirective        Define
hi def link lemonDirectiveArg     Normal
hi def link lemonNonTerminal      Type
hi def link lemonTerminal         Constant
hi def link cConstant             Constant
hi def link cType                 Type
hi def link cOperator             Operator
hi def link cStructure            Keyword
hi def link cStorageClass         Keyword
hi def link cFormat               cSpecial
hi def link cSpecial              SpecialChar
hi def link cCppString            cString

let b:current_syntax = "lemon"
