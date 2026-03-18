# Saving the project to a tar.gz archive

This document describes the process of creating a tar.gz archive of the project.

The following command was used to create the `project.tar.gz` file:

```bash
tar -czf project.tar.gz --exclude=node_modules --exclude=project.tar.gz .
```

This command recursively archives all files and directories in the current directory (`.`) into a file named `project.tar.gz`. The `--exclude=node_modules` and `--exclude=project.tar.gz` options exclude all directories named `node_modules` and the `project.tar.gz` file from the archive.
