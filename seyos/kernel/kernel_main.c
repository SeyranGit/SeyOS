int init_system(void) {

  return 0;
}


void kernel_main(void) {
  int icode = init_system();
  if (!icode) {
    while (1) {
      ;      
    }
  }
  return;
}
