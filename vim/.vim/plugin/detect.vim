au BufReadPost Jenkinsfile* set syntax=groovy
au BufReadPost Jenkinsfile* set filetype=groovy
au BufReadPost Capfile set filetype=ruby
au BufReadPost Vagrantfile set filetype=ruby
au BufReadPost sudoers set filetype=sudoers
au BufReadPost *.toml set filetype=toml
au BufReadPost Dockerfile* set filetype=dockerfile
au BufNewFile,BufRead *.thrift setlocal filetype=thrift

silent! autocmd! filetypedetect BufRead,BufNewFile *.tf
autocmd BufRead,BufNewFile *.hcl set filetype=hcl
autocmd BufRead,BufNewFile .terraformrc,terraform.rc set filetype=hcl
autocmd BufRead,BufNewFile *.tf,*.tfvars set filetype=terraform
autocmd BufRead,BufNewFile *.tfstate,*.tfstate.backup set filetype=json
