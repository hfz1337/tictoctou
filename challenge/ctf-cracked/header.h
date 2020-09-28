void setup();
void clear();
void welcome();
void goodbye();
void print_menu();
void how_to_play();
void draw_board();
void gameloop();
void bot_move();
void wait_for_user();
int checkwin();
int save_stats(char *, char *, int, int);
unsigned char getchoice();
unsigned char menu_choice();

unsigned char board[9];
unsigned char history[9];

char *byemsg = " _______________________________ \n"
               "< haha yes, boomers go brrrrrrr >\n"
               " ------------------------------- \n"
               "   \\         __------~~-,\n"
               "    \\      ,'            ,\n"
               "          /               \\\n"
               "         /                :\n"
               "        |                  '\n"
               "        |                  |\n"
               "        |                  |\n"
               "         |   _--           |\n"
               "         _| =-.     .-.   ||\n"
               "         o|/o/       _.   |\n"
               "         /  ~          \\ |\n"
               "       (____\\@)  ___~    |\n"
               "          |_===~~~.`    |\n"
               "       _______.--~     |\n"
               "       \\________       |\n"
               "                \\      |\n"
               "              __/-___-- -__\n"
               "             /            _ \\\n";
