package main

import (
	"fmt"
	"io/ioutil"
	"net/http"
	"os"
	"path"
)

var privateKey []byte
var filename string

func init() {
	filename, _ := os.Getwd()
	privateKey, _ = ioutil.ReadFile(path.Join(filename, "error.html"))
}

func main() {
	http.HandleFunc("/healthz", healhtzHandler)
	http.HandleFunc("/", errorHandler)
	http.ListenAndServe(":8000", nil)
}

func healhtzHandler(w http.ResponseWriter, r *http.Request) {
	fmt.Fprint(w, "Healthy as fuck")
}

func errorHandler(w http.ResponseWriter, r *http.Request) {
	w.WriteHeader(404)
	privateKey, _ = ioutil.ReadFile(path.Join(filename, "error.html"))
	fmt.Fprintf(w, string(privateKey))
}

//func errorHandler(w http.ResponseWriter, r *http.Request) {
//	w.WriteHeader(404)
//	buf := new(bytes.Buffer)
//
//	t, _ := template.New("foo").Parse(`{{define "T"}}Hello, {{.}}!{{end}}`)
//	_ = t.ExecuteTemplate(&foo, "T", "<script>alert('you have been pwned') /script>")
//	privateKey, _ = ioutil.ReadFile(path.Join(filename, "error.html"))
//	fmt.Fprintf(w, foo)
//}
