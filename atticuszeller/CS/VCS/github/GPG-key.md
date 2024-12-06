

[Generating a new GPG key - GitHub Docs](https://docs.github.com/en/authentication/managing-commit-signature-verification/generating-a-new-gpg-key)

> [!Note] user ID information
When asked to enter your email address, ensure that you enter the verified email address for your `GitHub` account. To keep your email address private, use your GitHub-provided `no-reply` email address. For more information, see "[Verifying your email address](https://docs.github.com/en/account-and-profile/setting-up-and-managing-your-personal-account-on-github/managing-email-preferences/verifying-your-email-address)" and "[Setting your commit email address](https://docs.github.com/en/account-and-profile/setting-up-and-managing-your-personal-account-on-github/managing-email-preferences/setting-your-commit-email-address)."

# Generate

```bash
gpg --full-generate-key
gpg --list-secret-keys --keyid-format=long
```

> [!NOTE] `3AA5C34371567BD2` is `YOUR_KEY_ID`
>
> ```bash
> $ gpg --list-secret-keys --keyid-format=long
> /Users/hubot/.gnupg/secring.gpg
> ------------------------------------
> sec   4096R/3AA5C34371567BD2 2016-03-10 [expires: 2017-03-10]
> uid                          Hubot <hubot@example.com>
> ssb   4096R/4BB6D45482678BE3 2016-03-10
> ```

# Export

```bash
gpg --armor --export YOUR_KEY_ID > public.key
gpg --armor --export-secret-key YOUR_KEY_ID > private.key
```

[Adding a GPG key to your GitHub account - GitHub Docs](https://docs.github.com/en/authentication/managing-commit-signature-verification/adding-a-gpg-key-to-your-github-account)
