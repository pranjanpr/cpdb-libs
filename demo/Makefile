CPDB_FRONTEND_FLAGS=$(shell pkg-config --cflags --libs cpdb-frontend)
GLIB_FLAGS=$(shell pkg-config --cflags --libs gio-2.0 gio-unix-2.0 glib-2.0)

.PHONY = all 

all: print_frontend pickle_test

#compile the sample frontend
print_frontend: print_frontend.c 
	gcc -g -pg -o $@ $^ -I.. -L../cpdb/.libs/ $(CPDB_FRONTEND_FLAGS) $(GLIB_FLAGS)

pickle_test: pickle_test.c
	gcc -g -pg -o $@ $^ -I.. -L../cpdb/.libs/ $(CPDB_FRONTEND_FLAGS)

clean:
	rm -f print_frontend pickle_test
