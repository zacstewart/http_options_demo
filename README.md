# HTTP Options Rails Demo
This little project demonstrates the usefulness of HTTP's OPTIONS method. The only resources are quotations.  Anyone may browse the index of them, view a specific one or create a new one. Only someone with the admin password can change or delete existing quotations.

## Install
1. `rvm 1.9.3` (or rbenv equivalent for that)
2. `bundle install`
3. `rake db:setup`
4. `rails s`

## Try some CURL
-v means verbose. It will display the entire request and response instead of just the response body.

-X specifies the HTTP method you want to use.

```bash
curl -v -X OPTIONS http://localhost:3000/quotations.json
```

The important things to notice with this response is the `Allow` header saying you have read and write permissions here. As stated above, anyone may create a new quotation via POST. Additionally, the response body contains some minimal instructions for creating a new quotation. It tells you all the parameters you need to know in order to POST.

```bash
curl -v -X OPTIONS http://localhost:3000/quotations/:id.json
```

Notice in this case, you are only permitted to read the resource. This is because non-admin's are not allowed to alter existing quotations. Such is reflected in the documenation of the response body.

```bash
curl -v -X OPTIONS --user admin:secret http://localhost:3000/quotations/:id.json
```

Now, after authenticating, you are granted full permissions to alter and delete quotations. Notice the additional documentation now present in the response body.


