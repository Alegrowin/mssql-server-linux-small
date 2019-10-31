# mssql_server_linux_small

## Description

A slightly modified Microsoft SQL Server docker image modified to allow execution on a Host with less than 2 GiB of physical memory

## The problem

Microsoft's sqlservr, at startup, looks to see how much physical memory its host has. If the host has less than 2 GiB sqlservr just quits with the message:

``` logs
sqlservr: This program requires a machine with at least 2000 megabytes of memory.
```

## Behind the scene

It turns out that sqlservr does not try to allocate that much memory and fail but rather sqlservr enforces that as a policy. Instead of using RAM, this will use SWAP space instead of physical memory when RAM fills up.
