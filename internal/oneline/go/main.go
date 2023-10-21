package main

import (
	"fmt"
	"os/exec"
	"strings"
)

func main() {
	// get text from pasteboard
	s := paste()
	fmt.Println(addQuotes(escape(s)))
}

func paste() string {
	cmd := exec.Command("pbpaste")
	out, _ := cmd.Output()
	return string(out)
}

func escape(s string) string {
	// replace newline to literal \n
	// replace " to literal \"

	s = strings.ReplaceAll(s, `\`, `\\`)
	s = strings.ReplaceAll(s, "\n", `\n`)
	s = strings.ReplaceAll(s, `"`, `\"`)
	return s
}

func addQuotes(s string) string {
	return `"` + s + `"`
}
