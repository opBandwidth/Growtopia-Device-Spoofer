[ENABLE]
//code from here to '[DISABLE]' will be used to enable the cheat
{$LUA}
function generateMAC()
    local MAC = ("XX:XX:XX:XX:XX:XX"):gsub("X", function()
        local randomIDX = math.floor(math.random() * 16)
        return ("0123456789ABCDEF"):sub(randomIDX, randomIDX)
    end)
    return MAC
end

function generateWK()
    local randomIDX
    local WK = ""
    for i = 1, 16 do
        randomIDX = math.random(0, 255)
        WK = ("%s%02x"):format(WK, math.random(0, randomIDX)):upper()
    end
    return WK
end

{$ASM}
aobscanmodule(addr,Growtopia.exe,49 83 C9 FF 45 33 C0 48 8B D0 48 8D 4D 20 E8 ?? ?? ?? FF 90 48 8D 4D C0 E8 ?? ?? ?? FF 90 48 8D 8D)
registersymbol(addr)
globalalloc(mac,2048,addr)
globalalloc(wk,2048,addr+666)
globalalloc(macf,19)
globalalloc(wkf,34)
luacall(writeString("macf",("%s\n"):format(genMAC(":"))))
luacall(writeString("wkf",("%s\n"):format(genWK())))

mac:
push r14
push r15
mov r14,[rax]
mov r15,[macf]
mov [r14+4],r15
mov r15,[macf+8]
mov [r14+C],r15
mov r15w,[macf+10]
mov [r14+14],r15w
mov r15l,[macf+12]
mov [r14+16],r15l
pop r15
pop r14
or r9,-01
xor r8d,r8d
mov rdx,rax
lea rcx,[rbp+20]
jmp addr+E

addr:
jmp mac

wk:
push r14
push r15
mov r14,[rax]
mov r15,[wkf]
mov [r14+3],r15
mov r15,[wkf+8]
mov [r14+B],r15
mov r15,[wkf+10]
mov [r14+13],r15
mov r15,[wkf+18]
mov [r14+1B],r15
mov r15w,[wkf+20]
mov [r14+23],r15w
pop r15
pop r14
or r9,-01
xor r8d,r8d
mov rdx,rax
lea rcx,[rbp+20]
jmp addr+674

addr+666:
jmp wk

[DISABLE]
//code from here till the end of the code will be used to disable the cheat
unregistersymbol(*)
addr:
db 49 83 C9 FF 45 33 C0 48 8B D0 48 8D 4D 20

addr+666:
db 49 83 C9 FF 45 33 C0 48 8B D0 48 8D 4D 20
