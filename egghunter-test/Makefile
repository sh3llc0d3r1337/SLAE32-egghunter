TEST=test


all: build

build: $(TEST)

$(TEST): $(TEST).c
	gcc -m32 $(TEST).c -fno-stack-protector -z execstack -ggdb -o $(TEST)

run: $(TEST)
	./$(TEST)

debug: $(TEST)
	gdb -q ./$(TEST) -tui

clean:
	rm -f $(TEST)
