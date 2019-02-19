--
-- p o s i x . u n i s t d
--
local unistd = { }

local ffi	= require('ffi')

require('posix.sys.types')

ffi.cdef([[
	int access (const char *name, int type);
	unsigned int alarm (unsigned int seconds);
	int chdir (const char *path);
	int chown (const char *file, uid_t owner, gid_t group);
	int close (int fd);
	size_t confstr (int name, char *buf, size_t len);
	int dup (int fd);
	int dup2 (int fd, int fd2);
	void _exit (int status);
	int execl (const char *path, const char *arg, ...);
	int execle (const char *path, const char *arg, ...);
	int execlp (const char *file, const char *arg, ...);
	int execv (const char *path, char *const argv[]);
	int execve (const char *path, char *const argv[], char *const envp[]);
	int execvp (const char *file, char *const argv[]);
	int faccessat (int fd, const char *file, int type, int flag);
	int fchdir (int fd);
	int fchown (int fd, uid_t owner, gid_t group);
	int fchownat (int fd, const char *file, uid_t owner, gid_t group, int flag);
	int fdatasync (int fildes);
	int fexecve (int fd, char *const argv[], char *const envp[]);
	pid_t fork (void);
	int fsync (int fd);
	int ftruncate (int fd, off_t length);
	char *getcwd (char *buf, size_t size);
	gid_t getegid (void);
	uid_t geteuid (void);
	int getgroups (int size, gid_t list[]);
	long int gethostid (void);
	int gethostname (char *name, size_t len);
	char *getlogin (void);
	int getlogin_r (char *name, size_t name_len);
	int getopt (int _argc, char *const *_argv, const char *shortopts);
	pid_t getpgid (pid_t pid);
	pid_t getpgrp (void);
	pid_t getpid (void);
	pid_t getppid (void);
	pid_t getsid (pid_t pid);
	uid_t getuid (void);
	int isatty (int fd);
	int lchown (const char *file, uid_t owner, gid_t group);
	int link (const char *from, const char *to);
	int linkat (int fromfd, const char *from, int tofd, const char *to, int flags);
	int lockf (int fd, int cmd, off_t len);
	off_t lseek (int fd, off_t offset, int whence);
	int nice (int inc);
	long int pathconf (const char *path, int name);
	int pause (void);
	int pipe (int pipedes[2]);
	ssize_t pread (int fd, void *buf, size_t nbytes, off_t offset);
	ssize_t pwrite (int fd, const void *buf, size_t n, off_t offset);
	ssize_t read (int fd, void *buf, size_t nbytes);
	ssize_t readlink (const char *path, char *buf, size_t len);
	ssize_t readlinkat (int fd, const char *path, char *buf, size_t len);
	int rmdir (const char *path);
	int setegid (gid_t gid);
	int seteuid (uid_t uid);
	int setgid (gid_t gid);
	int setpgid (pid_t pid, pid_t pgid);
	int setregid (gid_t rgid, gid_t egid);
	int setreuid (uid_t ruid, uid_t euid);
	pid_t setsid (void);
	int setuid (uid_t uid);
	unsigned int sleep (unsigned int seconds);
	int symlink (const char *from, const char *to);
	int symlinkat (const char *from, int tofd, const char *to);
	void sync (void);
	long int sysconf (int name);
	pid_t tcgetpgrp (int fd);
	int setpgrp (void);
	int truncate (const char *file, off_t length);
	char *ttyname (int fd);
	int ttyname_r (int fd, char *buf, size_t buflen);
	int unlink (const char *name);
	int unlinkat (int fd, const char *name, int flag);
	typedef unsigned int useconds_t;
	int usleep(useconds_t usec);
	ssize_t write (int fd, const void *buf, size_t n);
	char *optarg;
	int optind;
	int opterr;
	int optopt;
]])

return unistd
