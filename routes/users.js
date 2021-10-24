import express from 'express';
import {v4 as uuidv4} from 'uuid';

const router = express.Router();

let users = [ //DB for all users in Roomeet
    {
    firstName: "Sylvia",
    lastName: "Chen",
    age: 34,
    career: "Personal Trainer"
    },
    {
        firstName: "Robert",
        lastName: "Smith",
        age: 20,
        career: "Dance Instructor"
    },
    {
        firstName: "Aaron",
        lastName: "See",
        age: 17,
        career: "Line Cook",
        id: "86b3b1d4-300e-4ef8-89d1-bb17db212da7",
        selectedUsers: []
    },
    {
        firstName: "Jason",
        lastName: "Low",
        age: 19,
        career: "Nurse",
        id: "84e72111-cd7a-43ae-b593-598b3378a725",
        selectedUsers: []
    }

] //Users added here (Sylvia, Robert, Aaron, and Jason are added only for testing purposes)

let matchedUsers = [] //Represents DB for users that "match"
 
//Retrieve list of all users
router.get('/', (req,res)=> {
    res.send(users);
});

//Creation of new user, appends UUID and empty list representing users they swipe right on
router.post('/', (req,res) => {
    const newUser = req.body;
    const uniqueUserId = uuidv4();
    let matchedArray = [];
    const userWithAttachedId = {...newUser, id: uniqueUserId, selectedUsers: matchedArray};
    users.push(userWithAttachedId);
    res.send(`User ${userWithAttachedId.firstName} has been created.`);
});

//Retrieve user based on their UUID
router.get('/:id', (req,res) => {
    const { id } = req.params;
    const foundUser = users.find((eachUser) => eachUser.id == id);
    res.send(foundUser);
})

//Delete a user based on their UUID
router.delete('/:id', (req,res) => {
    const { id } = req.params;
    users = users.filter((eachUser) => eachUser.id != id);
    res.send("deletion complete");
})

//Edits user based on their UUID and fields given in the request body
router.patch('/:id', (req,res) => {
    const { id } = req.params;
    const {firstName, lastName, age, career} = req.body;
    const editingUser = users.find((eachUser) => eachUser.id == id);

    if(firstName) {
        editingUser.firstName = firstName;
    }
    if(lastName) {
        editingUser.lastName = lastName;
    }
    if(age) {
        editingUser.age = age;
    }
    if(career) {
        editingUser.career = career;
    }
    res.send("User has been successfully edited");
})

//SWIPE - req.params refers to user swiping and req.query refers to user being swiped
//Adds users that "match" in the matchedUsers array
router.post('/swipe/:id', (req,res) => {
    const userSwipingId  = req.params.id;
    const userSwipedId = req.query;
    const userSwiping = users.find((eachUser) => eachUser.id == userSwipingId);
    const userSwiped = users.find((eachUser) => eachUser.id == userSwipedId);
    if(userSwiped.selectedUsers.includes(userSwipingId)) {
        let newPairing = [];
        newPairing.push(userSwipingId);
        newPairing.push(userSwipedId);
        matchedUsers.push(newPairing);
    } else {
        userSwiping.selectedUsers.push(userSwipedId);
    }
    res.send(userSwiping);
})


export default router;