# covid_help

## This server program acts as a webhook destination endpoint for the whapi.io Unofficial Whatsapp API

The program deduplicates the messages (text,image,video or audio) by using a simple MD5 hash calculation. If
the entry (of hash signature) is already there it just updates the meta-data and if its not here it creates
a new entry in the database.

Feel free to use the program as a starting point to hookup Whatsapp (Whapi.io) system and build more systems / UI
over the database.
