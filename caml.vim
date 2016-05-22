" Vim syntax file
" Language:     Caml
" Filenames:    *.ml
" Maintainers:  Jouve Jean <jean-18-09@hotmail.fr>
" URL:          ~
" Last Change:  ~

syntax clear

" Caml is case sensitive.
syn case match

" lowercase identifier - the standard way to match
syn match    camlLCIdentifier /\<\(\l\|_\)\(\w\|'\)*\>/

syn match    camlKeyChar    "|"

" Errors
syn match    camlBraceErr   "}"
syn match    camlBrackErr   "\]"
syn match    camlParenErr   ")"
syn match    camlArrErr     "|]"

syn match    camlCommentErr "\*)"

syn match    camlCountErr   "\<downto\>"
syn match    camlCountErr   "\<to\>"

syn match    camlDoneErr    "\<done\>"
syn match    camlThenErr    "\<then\>"

" Error-highlighting of "end" without synchronization:
" as keyword or as error (default)
syn match    camlEndErr     "\<end\>"

" Some convenient clusters
syn cluster  camlAllErrs contains=camlBraceErr,camlBrackErr,camlCommentErr,camlCountErr,camlDoneErr,camlEndErr,camlThenErr

syn cluster  camlAENoParen contains=camlBraceErr,camlBrackErr,camlCommentErr,camlCountErr,camlDoneErr,camlEndErr,camlThenErr

syn cluster  camlContained contains=camlTodo


" Enclosing delimiters
syn region   camlEncl transparent matchgroup=camlKeyword start="(" matchgroup=camlKeyword end=")" contains=ALLBUT,@camlContained,camlParenErr
syn region   camlEncl transparent matchgroup=camlKeyword start="{" matchgroup=camlKeyword end="}"  contains=ALLBUT,@camlContained,camlBraceErr
syn region   camlEncl transparent matchgroup=camlKeyword start="\[" matchgroup=camlKeyword end="\]" contains=ALLBUT,@camlContained,camlBrackErr
syn region   camlEncl transparent matchgroup=camlKeyword start="\[|" matchgroup=camlKeyword end="|\]" contains=ALLBUT,@camlContained,camlArrErr


" Comments
syn region   camlComment start="(\*" end="\*)" contains=@Spell,camlComment,camlTodo
syn keyword  camlTodo contained TODO FIXME XXX NOTE


" Blocks
syn region   camlEnd matchgroup=camlKeyword start="\<begin\>" matchgroup=camlKeyword end="\<end\>" contains=ALLBUT,@camlContained,camlEndErr


" "for"
syn region   camlNone matchgroup=camlKeyword start="\<for\>" matchgroup=camlKeyword end="\<\(to\|downto\)\>" contains=ALLBUT,@camlContained,camlCountErr


" "do"
syn region   camlDo matchgroup=camlKeyword start="\<do\>" matchgroup=camlKeyword end="\<done\>" contains=ALLBUT,@camlContained,camlDoneErr

" "if"
syn region   camlNone matchgroup=camlKeyword start="\<if\>" matchgroup=camlKeyword end="\<then\>" contains=ALLBUT,@camlContained,camlThenErr

"Include
setlocal iskeyword+=#
syn keyword camlInclude #open
syn keyword camlInclude #close
syn keyword camlInclude #infix
syn keyword camlInclude #uninfix
syn keyword camlInclude #directory

"Keywords
syn keyword  camlKeyword  and as assert try
syn keyword  camlKeyword  else raise rec type
syn keyword  camlKeyword  fun when while with
syn keyword  camlKeyword  let match mutable of
syn keyword  camlKeyword  function in value ref
syn keyword  camlKeyword  prefix
syn keyword  camlBoolean  true false 

syn keyword  camlType     vect bool char exn float format format4
syn keyword  camlType     int int32 int64 lazy_t list nativeint option
syn keyword  camlType     string unit

syn keyword  camlOperator asr lnot lor lsl lsr lxor mod not

syn match    camlConstructor  "(\s*)"
syn match    camlConstructor  "\[\s*\]"
syn match    camlConstructor  "\[|\s*>|]"
syn match    camlConstructor  "\u\(\w\|'\)*\>"

" Polymorphic variants
syn match    camlConstructor  "`\w\(\w\|'\)*\>"

" Module prefix
syn match    camlModPath      "\u\(\w\|'\)* *\."he=e-1

syn match    camlCharacter    "`\\\d\d\d`\|`\\[\`ntbr]`\|`.`"
syn match    camlCharacter    "`\\x\x\x`"
syn match    camlCharErr      "`\\\d\d`\|`\\\d`"
syn match    camlCharErr      "`\\[^\`ntbr]`"
syn region   camlString       start=+"+ skip=+\\\\\|\\"+ end=+"+ contains=@Spell

syn match    camlFunDef       "->"
syn match    camlRefAssign    ":="
syn match    camlTopStop      ";;"
syn match    camlOperator     "\^"
syn match    camlOperator     "::"

syn match    camlOperator     "&&"
syn match    camlOperator     "<"
syn match    camlOperator     ">"
syn match    camlAnyVar       "\<_\>"
syn match    camlKeyChar      "|[^\]]"me=e-1
syn match    camlKeyChar      ";"
syn match    camlKeyChar      "\~"
syn match    camlKeyChar      "?"
syn match    camlKeyChar      "\*"
syn match    camlKeyChar      "="

syn match    camlOperator   "<-"

syn match    camlNumber        "\<-\=\d\(_\|\d\)*[l|L|n]\?\>"
syn match    camlNumber        "\<-\=0[x|X]\(\x\|_\)\+[l|L|n]\?\>"
syn match    camlNumber        "\<-\=0[o|O]\(\o\|_\)\+[l|L|n]\?\>"
syn match    camlNumber        "\<-\=0[b|B]\([01]\|_\)\+[l|L|n]\?\>"
syn match    camlFloat         "\<-\=\d\(_\|\d\)*\.\?\(_\|\d\)*\([eE][-+]\=\d\(_\|\d\)*\)\=\>"

" Labels
syn match    camlLabel        "\~\(\l\|_\)\(\w\|'\)*"lc=1
syn match    camlLabel        "?\(\l\|_\)\(\w\|'\)*"lc=1
syn region   camlLabel transparent matchgroup=camlLabel start="?(\(\l\|_\)\(\w\|'\)*"lc=2 end=")"me=e-1 contains=ALLBUT,@camlContained,camlParenErr


" Synchronization
syn sync minlines=50
syn sync maxlines=500

if !exists("caml_revised")
  syn sync match camlDoSync      grouphere  camlDo      "\<do\>"
  syn sync match camlDoSync      groupthere camlDo      "\<done\>"
endif

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_caml_syntax_inits")
  if version < 508
    let did_caml_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink camlBraceErr	   Error
  HiLink camlBrackErr	   Error
  HiLink camlParenErr	   Error
  HiLink camlArrErr	   Error

  HiLink camlCommentErr   Error

  HiLink camlCountErr	   Error
  HiLink camlDoneErr	   Error
  HiLink camlEndErr	   Error
  HiLink camlThenErr	   Error

  HiLink camlCharErr	   Error

  HiLink camlComment	   Comment

  HiLink camlConstructor  Constant

  HiLink camlKeyword	   Keyword
  HiLink camlFunDef	   Keyword
  HiLink camlRefAssign    Keyword
  HiLink camlKeyChar	   Keyword
  HiLink camlAnyVar	   Keyword
  HiLink camlTopStop	   Keyword
  HiLink camlOperator	   Keyword

  HiLink camlBoolean	   Boolean
  HiLink camlCharacter    Character
  HiLink camlNumber	   Number
  HiLink camlFloat	   Float
  HiLink camlString	   String

  HiLink camlLabel	   Identifier

  HiLink camlType	   Type

  HiLink camlTodo	   Todo

  HiLink camlEncl	   Keyword

  HiLink camlInclude       Include     

  delcommand HiLink
endif

let b:current_syntax = "caml"

" vim: ts=8
