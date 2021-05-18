require("dotenv").config();
const bcrypt = require("bcrypt");
//const { EMAIL, PASSWORD } = process.env

module.exports = {
  login: async (req, res) => {
    //db connection
    const db = req.app.get("db");
    const { username, email, password } = req.body;

    try {
        //check user info
        const existingUser = await db.check_user(username, email);

        if (!existingUser[0]) {
            return res.status(404).send('Username or password is incorrect')
        }

        //authentication
        const authenticated = bcrypt.compareSync(password, existingUser[0].password)

        if(!authenticated) {
            return res.status(409).send('Username or password is incorrect')
        }
        if(authenticated) {
            req.session.user = existingUser[0]
            res.status(200).send(existingUser[0])
        }
    } catch(err) {
        res.status(500).send('Something went wrong')
        //console.log(err) <- if there is a problem
    }
  },
  register: async (req, res) => {},
  registerAdmin: async (req, res) => {},
  getUser: async (req, res) => {},
  logout: async (req, res) => {}
};
