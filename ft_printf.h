#ifndef FT_PRINTF_H
# define FT_PRINTF_H

# include <unistd.h>
# include <stdlib.h>
# include <stdarg.h>

typedef struct s_spec
{
	int		minus;
	int		zero;
	int		plus;
	int		space;
	int		hash;
	int		width;
	int		precision;
	char	conv;
}			t_spec;

int			ft_printf(const char *format, ...);
char		*ft_strchr(const char *s, int c);
int			ft_atoi(const char *nptr);
const char	*parse_specs(const char *str, t_spec *spec);
size_t		ft_printchar(char c);
size_t		ft_printstr(char *str);
size_t		handle_conv(t_spec spec, va_list *args, size_t *count);
size_t		ft_printnum(unsigned long n, char *base);
size_t		ft_strlen(const char *s);
size_t		ft_printptr(void *ptr);
size_t		ft_printsign(long n);

#endif
