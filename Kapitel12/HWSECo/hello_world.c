#include <stdio.h>
#include <io.h>
#include <stdint.h>

#define BASE_ADDR ((volatile char*) 0x00011000)

#define MSG00_TEST 0b0101010101010101010101010 0000000
#define MSG01_TEST 0b0110010011101000111100010 0000000
#define MSG02_TEST 0b01001110010111101110001110000000
#define MSG03_TEST 0b0001100110011001100110011 0000000

const uint8_t gen = 0b10011001;
const uint32_t msg = MSG02_TEST;


void print_bits_impl(unsigned int num) {
	if (num > 1) {
		print_bits_impl(num / 2);
	}
	printf("%d", num % 2);
}

void print_bits(unsigned int num) {
	print_bits_impl(num);
	printf("\n");
}

int main() {
  printf("Hello from Nios II!\n");

  uint32_t gen_shifted = (gen << 24) + 1;

  printf("Inputs: \n");
  print_bits(msg);
  print_bits(gen_shifted);
  printf("Inputs end \n\n");


  IOWR(BASE_ADDR, 0, msg);
  print_bits(IORD(BASE_ADDR, 0));


  IOWR(BASE_ADDR, 4, gen_shifted);
  print_bits(IORD(BASE_ADDR, 4));

  uint32_t read;
  while ((read=IORD(BASE_ADDR, 4))) {
	printf("Waiting for CRC to finish\n");
	print_bits(read);
  }

  uint32_t ret = IORD(BASE_ADDR, 0);
  printf("Result");
  print_bits(ret);

  printf("Goodbye from NIOS II\n");
  return 0;
}
