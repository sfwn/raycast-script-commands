package main

import (
	"testing"
)

func Test_escape(t *testing.T) {
	type args struct {
		s string
	}
	tests := []struct {
		name string
		args args
		want string
	}{
		{
			name: "\n",
			args: args{s: `a
b`},
			want: `a\nb`,
		},
		{
			name: "with \"",
			args: args{s: `a"b`},
			want: `a\"b`,
		},
		{
			name: "with \\",
			args: args{s: `a\b`},
			want: `a\\b`,
		},
		{
			name: "all",
			args: args{s: `a"b
c\d`},
			want: `a\"b\nc\\d`,
		},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			if got := escape(tt.args.s); got != tt.want {
				t.Errorf("escape() = %v, want %v", got, tt.want)
			}
		})
	}
}
