extension Strings on String {
    /// Compares two strings by ignoring upper case characters
    bool equalsIgnoreCase(String comparison) =>
        this == comparison
            ? true
            : (comparison != null)
            && (this.length == comparison.length)
            && this.toLowerCase() == comparison.toLowerCase();
}