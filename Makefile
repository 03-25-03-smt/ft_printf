NAME=libftprintf.a

CC = cc
CFLAGS = -Wall -Wextra -Werror
AR = ar rcs
RM = rm -f

SRCS = srcs/handler.c \
	   srcs/parsing.c \
	   srcs/printers.c \
	   srcs/utils.c
OBJS = $(SRCS:.c=.o)

BONUS_SRCS = bonus/handler_bonus.c \
			 bonus/parsing_bonus.c \
			 bonus/printers_bonus.c \
			 bonus/utils_bonus.c \
			 bonus/filler_bonus.c
BONUS_OBJS = $(BONUS_SRCS:.c=.o)

VALGRIND = valgrind -q\
	--leak-check=full \
	--show-leak-kinds=definite,indirect,possible \
	--errors-for-leak-kinds=definite,indirect \
	--track-origins=yes \
	--num-callers=20 \
	--error-exitcode=1

$(NAME): $(OBJS)
	$(RM) $(NAME)
	$(AR) $(NAME) $(OBJS)
	$(RM) $(BONUS_OBJS)

all: $(NAME)

bonus: $(BONUS_OBJS)
	$(RM) $(NAME)
	$(AR) $(NAME) $(BONUS_OBJS)
	$(RM) $(OBJS)

%.o: %.c ft_printf.h
	$(CC) $(CFLAGS) -c $< -o $@

bonus/%.o: bonus/%.c bonus/ft_printf_bonus.h
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	$(RM) $(OBJS) $(BONUS_OBJS)

fclean: clean
	$(RM) $(NAME)

re: fclean all

test:	$(NAME)
	$(CC) -Wall -Wextra -g -I. -Wno-format -Wno-format-extra-args tests/main.c -L. -lftprintf -o tester
	$(VALGRIND) ./tester -v
	$(RM) $(OBJS) $(NAME)

.PHONY: all bonus clean fclean re test
