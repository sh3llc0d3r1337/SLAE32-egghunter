SHELLCODE=shellcode
TEST=test


all: build hex

build: $(SHELLCODE).o
	ld -m elf_i386 -o $(SHELLCODE) $(SHELLCODE).o

$(SHELLCODE).o: $(SHELLCODE).asm
	nasm -f elf32 -o $(SHELLCODE).o $(SHELLCODE).asm

run: $(SHELLCODE)
	./$(SHELLCODE)

debug: $(SHELLCODE)
	gdb -q ./$(SHELLCODE) -tui

disassemble: $(SHELLCODE)
	objdump -d $(SHELLCODE) -M intel

hex: $(SHELLCODE)
	@echo "Size of shellcode:"
	@size shellcode
	@echo ""
	@echo "Shellcode:"
	@objdump -d ./$(SHELLCODE)|grep '[0-9a-f]:'|grep -v 'file'|cut -f2 -d:| \
	cut -f1-7 -d' '|tr -s ' '|tr '\t' ' '|sed "s| $$||g" |sed "s/ /\\\\x/g"| \
	paste -d '' -s | sed "s|^|\"|" | sed "s|$$|\"|g" > $(SHELLCODE).txt
	@cat $(SHELLCODE).txt

clean:
	rm -f $(SHELLCODE).txt
	rm -f $(SHELLCODE).o
	rm -f $(SHELLCODE)
