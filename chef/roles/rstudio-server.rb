# Name of the role should match the name of the file
name "rstudio-server"

# Run list function we mentioned earlier
run_list(
    "recipe[R]"
)