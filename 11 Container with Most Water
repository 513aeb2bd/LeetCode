FORMAT MS64 COFF

PUBLIC maxArea as 'maxArea'

SECTION '.code' code readable executable

maxArea:
        ; rcx-in: heights array (left post addr)
        ; rdx-in: number of posts

        ; rax: tmp area
        ; rcx: heights array
        ; rdx: tmp
        ; rbx: shorter post height
        ; r8: tmp L post addr
        ; r9: tmp R post addr
        ; r12: L post addr
        ; r13: R post addr

        ; [rsp]: max area

        PUSH rbx
        PUSH r12
        PUSH r13
        SUB rsp, 8

        XOR rbx, rbx
        CMP rdx, 10000000h
        JNC BRAN_heightsException ; if "number of posts" >= 2^32 then return 0
        SUB rdx, 1
        JBE BRAN_heightsException ; if "number of posts" <= 1 then return 0
        MOV r8, rcx ; L post addr
        LEA r9, BYTE [rdx*4 + rcx] ; R post addr
        MOV r12, rcx ; L post addr
        MOV r13, r9 ; R post addr

        ; get initial "max area"

        MOV rax, rdx ; move initial width of posts ("number of posts" - 1)
        MOV ebx, DWORD [r8]
        CMP ebx, DWORD [r9]
        JC BRAN_doNotExchange ; if "tmp L post height" < "tmp R post height" then "shorter post height" = "tmp L post height"
        MOV ebx, DWORD [r9] ; else, "shorter post height" = "tmp R post height"

        BRAN_doNotExchange:

        MUL rbx ; "tmp area" = ("number of posts" - 1) * "shorter post height"
        MOV QWORD [rsp], rax ; "max area" = "tmp area"

        LOOP_forever:
          MOV ebx, DWORD [r8]
          CMP ebx, DWORD [r9]
          JC BRAN_moveLeftPost ; if "tmp L post height" < "tmp R post height" then move "tmp L post"

          ; move "tmp R post"

          MOV ebx, DWORD [r13]

          LOOP_untilTallerRightPost:
            CMP r9, r12
            JZ BRAN_calcDone ; if "tmp R post" == "L post" then return "max area"

            SUB r9, 4
            CMP ebx, DWORD [r9]
            JNC LOOP_untilTallerRightPost ; if "R post height" >= "tmp R left post height" then move "tmp R post" again
          ;;; LOOP_untilTallerRightPost

          JMP BRAN_compareArea ; get "temp area"

          ; move "tmp L post"

          BRAN_moveLeftPost:

          MOV ebx, DWORD [r12]

          LOOP_untilTallerLeftPost:
            CMP r8, r13
            JZ BRAN_calcDone ; if "tmp L post" == "R post" then return "max area"

            ADD r8, 4
            CMP ebx, DWORD [r8]
            JNC LOOP_untilTallerLeftPost ; if "L post height" >= "tmp L post height" then move "tmp L post" again
          ;;; LOOP_untilTallerLeftPost

          BRAN_compareArea:

          ; get "tmp area"

          MOV r12, r8 ; "L post" = "tmp L post"
          MOV r13, r9 ; "R post" = "tmp R post"
          MOV ebx, DWORD [r8]
          CMP ebx, DWORD [r9]
          JC BRAN_doNotExchange2 ; if "tmp L post height" < "tmp R post height" then "shorter post height" = "tmp R post height"
          MOV ebx, DWORD [r9] ; else, "shorter post height" = "tmp R post height"

          BRAN_doNotExchange2:

          MOV rax, r9
          SUB rax, r8 ; rax = "tmp R post" - "tmp L post"
          MUL rbx ; "tmp area" = ("tmp R post" - "tmp L post") * "shorter post height"
          SHR rax, 2 ; divide "tmp area" by 4 because address is 4 bytes

          ; compare area

          CMP rax, QWORD [rsp]
          JC LOOP_forever ; if "tmp area" < "max area" then do not modify "max area"
          MOV QWORD [rsp], rax ; else, "max area" = "tmp area"
          JMP LOOP_forever
        ;;; LOOP_forever

        BRAN_heightsException:

        MOV QWORD [rsp], 0 ; return 0

        BRAN_calcDone:

        POP rax ; return "max area"
        POP r13
        POP r12
        POP rbx

        RET
;;; maxArea
