db.createUser (
 {
   user: "Username",
   password: "Password",
   roles: [
   {
    role: "readwrite",
    db: "shop_db"
    }
   ]
}
)
