cb() {
  n=${1:-1}
  while ((n-- > 0)); do
    cd .. || break
  done
}
