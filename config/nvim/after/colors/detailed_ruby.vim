" Rough Coal / Comments
hi!   rubyComment             guifg='#5B4B43'
hi!   rubyDocumentation       guifg='#796a58'
hi!   NonText                 guifg='#322726'
hi!   link                    rubyMultilineComment   rubyComment
hi!   link                    rubyFirstAndSecondCommentLine rubyComment

" x $lumio0: #241C1C;
" x $lumio1: #322726;
" x $lumio2: #443533;
" x $lumio2.5: #5B4B43 -- not a lumio color but half way between 2 and 3 -
" x $lumio3: #6A5A4E;
" x $lumio4: #796A58;

" Obviously this is not highlighted at all.  Don't use this constrcut
hi!   rubyData                guifg='#000000' guibg='#FFFFFF'

hi!   rubyTodo                guifg='#FF3333' guibg='#241C1C'

" x $lumio65: #CF7B43; borrowed from CalmSunset

hi!   rubySharpBang           guifg='#843C35' guibg='#322726'
hi!   rubyEncodingDirective   guifg='#93573F'

" x $lumio47: #843C35; borrowed from Tropical Wood
" x $lumio44: #93573F; borrowed from Roasted Coffee

"Soft Earth / Strings
hi!   rubyInterpolationDelimiter        guifg='#A3743B'
hi!   rubyExecutedString                guifg='#AF873E'  guibg='#241C1C'
hi!   rubyInterpolatedString            guifg='#885735'
hi!   rubyString                        guifg='#7A4830'
hi!   rubyQuoteEscape                   guifg='#68402F'
hi!   rubyDelimiterEscape               guifg='#5D392A'
hi!   rubyStringEscape                  guifg='#976538'
hi!   rubyASCIICode                     guifg='#52352A'
hi!   rubyHeredoc                       guifg='#7A4830'

hi!   link   rubyInterpolatedStringDelimiter   rubyInterpolatedString
hi!   link   rubyStringDelimiter               rubyString
hi!   link   rubyExecutedStringDelimiter       rubyExecutedString

"hi!   rubyNoInterpolation #trans
"$lumio5:    #462D24;
"x $lumio6:  #52352A;
"x $lumio7:  #5D392A;
"x $lumio8:  #68402F;
"x $lumio9:  #7A4830;
"x $lumio10: #885735;
"x $lumio11: #976538;
"x $lumio12: #A3743B;
"x $lumio13: #AF873E;

" Control / Clear Water
hi!   rubyControl               guifg='#4DC4B1'
hi!   rubyConditional           guifg='#1398A9'
hi!   rubyConditionalModifier   guifg='#046CA5'
hi!   rubyKeyword               guifg='#0480A4'
hi!   rubyRepeat                guifg='#046397'
hi!   rubyRepeatModifier        guifg='#26A4AD'
hi!   rubyEval                  guifg='#54DEB2'
hi!   link                      rubyStabbyProc    rubyKeyword
hi!   rubyExceptional           guifg='#36B4B0'
hi!   rubyMethodExceptional     guifg='#04598F'

"x $lumio26: #04598F;
"X $lumio27: #046397;
"X $lumio28: #046CA5;
"X $lumio29: #0480A4;
"X $lumio30: #1398A9;
"X $lumio31: #26A4AD;
"x $lumio32: #36B4B0;
"x $lumio33: #4DC4B1;
"x $lumio34: #54DEB2;


" Barewords in Scopes


" class scope
hi!   rubyException           guifg='#B28142'
hi!   rubyExitSpecial         guifg='#A36A41'
hi!   rubyInterpolation       guifg='#CF7B43'

" Roasted Coffee Beans
" $lumio41: #59313B;
" x $lumio42: #6F393A;
" x $lumio43: #80483D;
" $lumio44: #93573F;
" x $lumio45: #A36A41;
" x $lumio46: #B28142;

hi! clear rubyLocalVariableOrMethod

" This arelistted in the order in which they are likely to appear

hi!   rubyBlock                   guifg='#ddddee'
hi!   rubyMethodBlock             guifg='#c4c4d5'
hi!   rubyCaseExpression          guifg='#b8b8c9'
hi!   rubyRepeatExpression        guifg='#acabbd'
hi!   rubyConditionalExpression   guifg='#888899'
hi!   rubyBlockExpression         guifg='#888899'
hi!   rubyCurlyBlock              guifg='#9494a5'
hi!   rubyDoBlock                 guifg='#a09fb1'

hi!   rubyArgumentList        guifg='#93573F'
hi!   rubyBlockArgumentList   guifg='#80483D'
" hi!   rubyKeywordAsMethod

" #ddddee
" #d1d0e2
" #c4c4d5
" #b8b8c9
" #acabbd
" #a09fb1
" #9494a5
" #888899

" Roasted Coffee Beans
" $lumio41: #59313B;
" x $lumio42: #6F393A;
" $lumio43: #80483D;
" $lumio44: #93573F;
" x $lumio45: #A36A41;
" $lumio46: #B28142;

" the optional do (and line containing it in for and while loop
hi! clear rubyOptionalDo
hi! clear rubyOptionalDoLine

" this doesn't highlight and is used to prevent method calls like .yield or
" .return from being higlighted as keywords

" Variable Types / Hot Flame
hi!   rubyGlobalVariable       guifg='#D47055'
hi!   rubyClassVariable        guifg='#C1604D'
hi!   rubyInstanceVariable     guifg='#A84E4E'
hi!   rubyPseudoVariable       guifg='#904851'
hi!   rubyPredefinedVariable   guifg='#784452'
hi!   rubyArgAsProc            guifg='#784452'
hi!   rubyHeredocDelimiter     guifg='#553A47'

" x $lumio35: #553A47;
" x $lumio36: #784452;
" x $lumio37: #904851;
" x $lumio38: #A84E4E;
" x $lumio39: #C1604D;
" x $lumio40: #D47055;

" Constants Sweet Banana
hi!   rubyCapitalizedMethod    guifg='#ECCF49'
hi!   rubyConstant             guifg='#CDA544'
hi!   rubyPredefinedConstant   guifg='#B28142'
hi!   rubyBeginEnd             guifg='#945F3C'

" x $lumio57: #945F3C;
" x $lumio58: #B28142;
" x $lumio59: #CDA544;
" x $lumio60: #ECCF49;

" Variable Types / Tropical Wood

hi!   rubySymbol    guifg='#BA7845' gui=NONE
hi!   rubyBoolean   guifg='#9C4C3D'
hi!   rubyFloat     guifg='#AD6143'
hi!   rubyInteger   guifg='#C99147'
hi!   link          rubySymbolDelimiter   rubySymbol

" $lumio47:   #843C35;
" x $lumio48: #9C4C3D;
" x $lumio49: #AD6143;
" x $lumio50: #BA7845;
" x lumio51:  #C99147;
"
" Declarations Deep Sea
" class Definitions
hi!   rubyModule        guifg='#1F6C6B'
hi!   rubyClass         guifg='#20806A'
hi!   rubyAttribute     guifg='#469870'
hi!   rubyDefine        guifg='#75B47A'
hi!   rubyDoEnd         guifg='#8CC47B'

" These are only highlight when doing _extremely_ non-standard class declarations
" like class a_method_that_return_a_constant"
" hi!   rubyModuleDeclaration
" hi!   rubyClassDeclaration
" hi!   rubyMethodDeclaration
"
" I can't find a situation in which these are ever used - they might be
" structural groups only
" hi! rubyAliasDeclaration
" hi! rubyAliasDeclaration2

" x $lumio71: #1F6C6B;
" x $lumio72: #20806A;
" X $lumio73: #469870;
" x $lumio74: #75B47A;
" x $lumio75: #8CC47B;

" Function Definitions Living Forest
hi!   rubyInclude       guifg='#505B1E'
hi!   rubyInheritance   guifg='#626B20'
hi!   rubyAccess        guifg='#777922'
hi!   rubyFunction      guifg='#A9A37E'
hi!   rubyInitialize    guifg='#89BB23'

" x $lumio66: #505B1E;
" x $lumio67: #626B20;
" x $lumio68: #777922;
" x $lumio69: #898B23;
" x $lumio70: #9D9F28;
"
"" Piquant Olive
" $lumio18:   #817B60;
" $lumio19:   #958E6F;
" x $lumio20: #A9A37E;
" $lumio21:   #CCC9AA;

"
"" Misc
hi!   rubyOperator              guifg='#8C7168'
hi!   rubyArrayDelimiter        guifg='#A26846'
hi!   rubyBracketOperator       guifg='#BF8953'
hi!   rubyInvalidVariable       guifg='#CC0000'
hi!   rubyDataDirective         guifg='#C59759'
hi!   rubyCurlyBlockDelimiter   guifg='#8C7168'
hi! link rubyPipeOperator rubyOperator
hi! link rubyAmperdot rubyOperator
hi! link rubyLineContinuation NonText

" Not defined
" hi! rubySpaceError
"
" These groups don't ever highlight, and are just to keep track of the current
" nest level
"
" rubyNestedAngleBrackets
" rubyNestedCurlyBraces
" rubyNestedParentheses
" rubyNestedSquareBrackets

" Hard Metal / Symbols / Literals
"  $lumio14:  #7E625E;
" x $lumio15: #8C7168;
"  $lumio16:  #9D8275;
"  $lumio17:  #A9917E;
"
" Fine Sand
" x $lumio52: #A26846;
" x $lumio53: #B67D4F;
" x $lumio54: #BF8953;
" x $lumio55: #C59759;
" x $lumio56: #CBA65B;
" x #CC000 not a lumio color - this is a hard error to come up with

"
"Regexes / Fresh Wildberries
"Regex all have a purpule background
hi! rubyRegexpComment guifg='#796A58' guibg='#2E0854'
hi! rubyRegexpSpecial guifg='#664D6E' guibg='#2E0854'
hi! rubyRegexp guifg='#AB629C' guibg='#2E0854'
hi! rubyRegexpAnchor guifg='#FFA500' guibg='#2E0854'
hi! rubyRegexpBrackets guifg='#975E95' guibg='#2E0854'
hi! rubyRegexpCharClass guifg='#E59522' guibg='#2E0854'
hi! rubyRegexpDelimiter guifg='#56445b' guibg='#2E0854'
hi! rubyRegexpDot guifg='#AB629C' guibg='#2E0854'
hi! rubyRegexpEscape guifg='#E066FF' guibg='#2E0854'
hi! rubyRegexpParens guifg='#714f70' guibg='#2E0854'
hi! rubyRegexpQuantifier guifg='#976842' guibg='#2E0854'

" x $lumio4:  #796A58; borrowed from RoughCoal - standard comment collor
" x $lumio76: #483F50;
" x $lumio77: #664D6E;
" x $lumio78: #7F5583;
" x $lumio8:  #68402F; borrowed from Soil
" x $lumio79: #975E95;
" x $lumio80: #AB629C;
" This one has several non-lummio colors to ensure that special characters
" contracst with the purple background
"
"
"Rails.vim Highlight Groups

hi! link rubyMacro rubyAttribute
hi! clear rubyHelper
hi! clear rubyResponse
hi! clear rubyRoute
hi! clear rubySchema
hi! clear rubyEntitiy
hi! clear rubyCallback
hi! clear rubyViewHelper


" Cold Snow
" $lumio22: #CCAFAA;
" $lumio23: #D8C0B6;
" $lumio24: #E3D0C4;
" $lumio25: #E9DBCC

" Piquant Olive
" $lumio18: #817B60;
" $lumio19: #958E6F;
" $lumio20: #A9A37E;
" $lumio21: #CCC9AA;
"
" Calm Sunset
" $lumio61: #8D492B;
" $lumio62: #9C522F;
" $lumio63: #AD5E33;
" $lumio64: #BF6B3E;
" $lumio65: #CF7B43;
"
"
" Roasted Coffee Beans
" $lumio41: #59313B;
" $lumio42: #6F393A;
" $lumio43: #80483D;
" $lumio44: #93573F;
" $lumio45: #A36A41;
" $lumio46: #B28142;
