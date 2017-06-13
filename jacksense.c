#include <unistd.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <linux/input.h>
#include <errno.h>

int main(int argc, char *argv[])
{
	char const *input;
	int inputfd;
	struct input_event event;
	ssize_t bytes;

	if (argc == 2)
		input = argv[1];
	else {
		fprintf(stderr, "Specify input device path. eq /dev/input/event2\n");
		return 2;
	}

	do {
		inputfd = open(input, O_RDONLY);
	} while (inputfd == -1 && errno == EINTR);

	if (inputfd == -1) {
		fprintf(stderr, "%s: Cannot open input device.\n", input);
		system("echo \"open fail\" > /tmp/log.txt");
		return 1;
	}

	while(1) {
		do {
			bytes = read(inputfd, &event, sizeof(event));
			if (bytes == (ssize_t)-1 && errno == EINTR)
			{
				break;
			}
			else if (bytes == (ssize_t) sizeof(struct input_event))
			{
				if (event.type == 5 && event.code == 2)
				{
					if( event.value) {
						//fprintf(stdout, "=====Headphone plugged=====\n");
						system("/usr/local/bin/cx-jack-headphone.sh");
						system("echo \"headphone plugged\" > /tmp/log.txt");
					} else {
						//fprintf(stdout, "=====Headphone unplugged=====\n");
						system("/usr/local/bin/cx-jack-speaker.sh");
						system("echo \"headphone unplugged\" > /tmp/log.txt");
					}
				}
//				#fprintf(stdout, "event type =%d.\n", event.type);
//				#fprintf(stdout, "      code =%d.\n", event.code);
//				#fprintf(stdout, "      value =%d.\n", event.value);
			}
		} while (bytes == (ssize_t)-1 && errno == EINTR);

		if (bytes != (ssize_t) sizeof(struct input_event))
			break;
	}

	close(inputfd);
	return 0;
}

