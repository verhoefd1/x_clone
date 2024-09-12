//NODE SERVER SET UP SECTION ----------------------------------------------------------------------------------------------------------------------
const
    express = require("express"),
    app = express(),
    session = require("express-session"),
    bodyParser = require("body-parser"),
    serverName = "X-clone",
    port = process.env.PORT || 8080,
    mysql = require("mysql2"),
    bcrypt = require("bcrypt");

// serves all files in public and assets directory to /
app.use(express.static(__dirname + "/public"));
// app.use(express.static(__dirname + "/views/assets"));

//creates middleware link to be able to parse https clals: 
app.use(bodyParser.urlencoded({ extended: true }));

//adds middleware to all routes so that everything in view is made available at root and removes the need for file ext. 
app.set("views", __dirname + "/views/");
app.set("public", __dirname + "/public/");
app.set("view engine", "ejs");

// set up express sessions - to be removed for session storage in MySQL or REDIS
app.use(session({
    secret: 'alsdkfajs2-amsdkfDkj2l-a;lskfjewdfFDa',       // Replace with a secure secret key
    resave: false,                   // Forces the session to be saved back to the session store, even if it wasn't modified during the request
    saveUninitialized: false,        // Don't create a session until something is stored
    cookie: { secure: false }        // Set to `true` if you're using HTTPS; otherwise, keep it `false` for development
}));

// connect to the database
const db = mysql.createConnection({
    host: 'x_database',
    user: 'root',
    password: 'mdjdf-masle1-poasD9',
    database: 'x_db'
});

//END NODE SERVER SET UP SECTION ----------------------------------------------------------------------------------------------------------------------
//POST ROUTE FUNCTIONS --------------------------------------------------------------------------------------------------------------------------------
// Function to generate and return a unique user ID
const generateUserId = (callback) => {
    db.query('SELECT UUID() AS user_id', (err, results) => {
        if (err) throw err;             // Throw an error if the query fails
        console.log(results[0].user_id);
        callback(results[0].user_id);        // Call the callback function with the generated UUID
    });
};
// Password validation function
const validatePassword = (password) => {
    // Regular expression to enforce the password policy
    const regex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/;
    return regex.test(password);
};
//END POST ROUTE FUNCTIONS ----------------------------------------------------------------------------------------------------------------------------
// INDEX ROUTE
app.get("/", function (req, res) {
    document = req.body;
    res.render("index", { document: document });
});

// USER ROUTES
app.post("/register", async (req, res) => {
    const { name, email, dateofbirth, password } = req.body;
    if (!validatePassword(password)) {
        return res.render("signup", { pass_err: 'bad_pass', site: "signup" });
        // return res.status(400).send('Password must be at least 8 characters long, include at least one lowercase letter, one uppercase letter, one digit, and one special character.');
    };

})


//test connection to MYSQL
app.connect((err) => {
    if (err) throw err;
    console.log('Connected to MySQL database.');
});

//Log that server is up and running. 
app.listen(port, function () {
    // using the ${port} syntax means that it takes it as a template literaly and will pull in the port number dynamically
    console.log(serverName + " is now listening on port: " + port);
});
