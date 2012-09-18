!define CheckGtkVersion "!insertmacro CheckGtkVersion"
 
!macro  CheckGtkVersion Found Major  Minor   Build
    Push    `${Build}`
    Push    `${Minor}`
    Push    `${Major}`
    Call    CompareGtkVersion
    Pop     `${Found}`
!macroend
 
Function CompareGtkVersion

  ; Initialize variables
  Var /GLOBAL explMajor
  Var /GLOBAL explMinor
  Var /GLOBAL explBuild  
  Var /GLOBAL explTmpMajor
  Var /GLOBAL explTmpMinor
  Var /GLOBAL explTmpBuild 
 
  ; Get input from user
  Pop $explMajor
  Pop $explMinor
  Pop $explBuild
 
  ; Calculates initial values
  
  StrCpy $explTmpMajor  0
  StrCpy $explTmpMinor 0
  StrCpy $explTmpBuild 0   
  
  
  
  ReadRegStr $1 HKLM "Software\Novell\GtkSharp\Version" ""
  ;MessageBox  MB_OK "$1 version" 
  ;DetailPrint "GTK is $1 " 
  ${Explode}  $0  "." $1
  ;MessageBox  MB_OK "$0 elements in array" 
  ${For} $3 1 $0
        ${If}   $3 = 1
            Pop $explTmpMajor
        ${EndIf}
        ${If}   $3 = 2
            Pop $explTmpMinor
        ${EndIf}
        ${If}   $3 = 3
            Pop $explTmpBuild
        ${EndIf} 
        ;Pop $2
        ;DetailPrint "Element A#$3: $explTmpMajor - $explTmpMinor - $explTmpBuild"             
      ; MessageBox MB_OK "Element A#$3: $2"
  ${Next}
 
  ${If}   $explTmpMajor < 2    
    Push    0           
    Return
  ${EndIf}
 
  ${If}   $explTmpMinor < 12    
    Push    0           
    Return
  ${EndIf}
   
  Push 1
FunctionEnd