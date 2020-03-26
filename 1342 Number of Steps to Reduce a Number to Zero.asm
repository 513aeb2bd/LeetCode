FORMAT MS64 COFF

PUBLIC numberOfSteps

SECTION '.code' code readable executable

; WMWMWMW WMWMWMW WMWMWMW WMWMWMW WMWMWMW WMWMWMW WMWMWMW WMWMWMW WMW
; LeetCode 1342: Number of Steps to Reduce a Number to Zero WMWMW WMW
; WMWMWMW WMWMWMW WMWMWMW WMWMWMW WMWMWMW WMWMWMW WMWMWMW WMWMWMW WMW

numberOfSteps:
        ; rcx-in: number

        ; rcx: number's LSB
        ; rdx: number
        ; rax: steps

        XCHG rcx, rdx
        XOR rax, rax
        TEST rdx, rdx
        JZ _BRAN_calcDone    ; if "number" is 0, then return 0
        LOOP_forever:
            INC rax    ; increment "steps"
            TEST dl, 1    ; check if "number" is odd or even
            SETNZ cl
            SHR rdx, 1    ; divide "number" by 2
            SHL rdx, cl    ; if "number" was odd, then multiply "number" by 2
            JNZ LOOP_forever    ; if "number" is not 0
       _BRAN_calcDone:
RET
