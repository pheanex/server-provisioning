$TTL 86400;
$ORIGIN manna.uno.

@               IN      SOA     ns hostmaster ( {{ansible_date_time.epoch}} 43200 5400 604800 10800 )
                IN      DNSKEY  257 3 7 AwEAAcQ2Pd9FlB9btiZo0vbceWu4K+r9lV38Kjejk7dXW0k1efCIfwpL Bvq6iCw5yS51RHm1wQ2yRM1lOCtKQ0bqxjPEKKyiT4K/YoEzngd0WWeJ NxOpwvj9pod2NVDWwIZO+e/EP4DU0SoBYgdP7BmGm9XzSVG12dBQuJ6I kvxwCccXybR+lI8UshmMf6ILTiMHSTIrgmenCKJDSF2lywtb2NYZHIOM b5HnE2k9bmjXLeqCu8Vg7XJUDuar6Mrpsmgj0MXBSFTdBxw+no+s58ov ZD4coUDSE9iB7FwdNkb9NFatOC3iBAhX/TFW7rclhPxhXkoLEkirLbvy wC+BbrsqghvlEsZSWyDL72/3QyjFmVzvRTHLEVT9L+VGru20cM171ft2 uPNgSrelSgb1ksfVYXK7YPRnreV3CIF6MFNvUJSZmZZ9knIgWjAA+/Jh QaUWdcA3ZrvFilrR3b6ysr+Zbh9OK1Cw5qjKELLiZRVgDLiTdMOu87CP C3onWw/sGR8dcWHrKoYx6JStw9diEWvzcXicpMC223Ko6Zhqm62hWCCI GjWEwWLvC000ws+0kVSJKEeb7gBKZAmT8dylxf4YpVL0zSL7BZXlilCo oEcKi1nAeCsK4mlH7xpNTlH+zCj5TYzPkk27sMLGx1UFv512Kll615Z2 oU7KeqbjEhEHhYjV
                IN      DNSKEY  256 3 7 AwEAAcvfdoFvTLJ9wKFnDxNCAKNTLF0i2/qRLNNeDcegXy8+aE/12wkG HcrLbLmyMqB3wFuptkLRdG9rzXCR3uMfKb5qzmxiEo6Mun300MuLEIV7 k/wg8fqI6ULGx0pIsuWzCRG8bfQJa+5mTU3/f3MwoHXct6twaEsLGVRR vlSsODihOFWpxpUAtQN3UmwiMZGv357Nx7ch1bcOJU7NAmEiv8IQBeLZ jpcJbnU3nbQdST3xVvwRq3LwWrut/7nGTwtt5m7rMedlFNCvXUrvZOgP AtitieGAQcXwrFLjOFFOHBxOnamD0mGE9koTsJ6/3uhD3wktb1/28KD7 cBlSitg502M=
                IN      NS      ns.pheanex.de.
                IN      NS      ns2.nonymus.de.
                IN      MX      10 mail
                IN      MX      20 mail
                IN      A       {{ansible_default_ipv4.address}}
                IN      AAAA    {{ansible_default_ipv6.address}}
                IN      SSHFP   1 1 2479AA44B9F4D8C08C340609F3DAA495584485AF
                IN      SSHFP   2 1 4DF9856C2FCE409F23D4292A32F53CA0AA650F1F
ns              IN      A       {{ansible_default_ipv4.address}}
                IN      AAAA    {{ansible_default_ipv6.address}}
                IN      MX      10 mail
                IN      MX      20 mail
                IN      SSHFP   1 1 2479AA44B9F4D8C08C340609F3DAA495584485AF
                IN      SSHFP   2 1 4DF9856C2FCE409F23D4292A32F53CA0AA650F1F
nardin          IN      CNAME   {{hostname}}
konstantin      IN      CNAME   {{hostname}}
{{hostname}}           IN      A       {{ansible_default_ipv4.address}}
                IN      AAAA    {{ansible_default_ipv6.address}}
                IN      MX      10 mail
                IN      MX      20 mail
                IN      SSHFP   1 1 2479AA44B9F4D8C08C340609F3DAA495584485AF
                IN      SSHFP   2 1 4DF9856C2FCE409F23D4292A32F53CA0AA650F1F
mail            IN      A       {{ansible_default_ipv4.address}}
                IN      AAAA    {{ansible_default_ipv6.address}}
                IN      MX      10 mail
                IN      MX      20 mail
                IN      SSHFP   1 1 2479AA44B9F4D8C08C340609F3DAA495584485AF
                IN      SSHFP   2 1 4DF9856C2FCE409F23D4292A32F53CA0AA650F1F
{{hostname}}4          IN      A       {{ansible_default_ipv4.address}}
                IN      SSHFP   1 1 2479AA44B9F4D8C08C340609F3DAA495584485AF
                IN      SSHFP   2 1 4DF9856C2FCE409F23D4292A32F53CA0AA650F1F
{{hostname}}6          IN      AAAA    {{ansible_default_ipv6.address}}
                IN      SSHFP   1 1 2479AA44B9F4D8C08C340609F3DAA495584485AF
                IN      SSHFP   2 1 4DF9856C2FCE409F23D4292A32F53CA0AA650F1F
nardin4         IN      CNAME   {{hostname}}4
nardin6         IN      CNAME   {{hostname}}6
