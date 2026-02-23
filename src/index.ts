interface User {
firstName: string,
lastName: string,	
}

function greet(user: User): string {
	return `Hello, ${user.firstName} ${user.lastName}!`;
}

const person = {
	firstName: "Josephine",
	lastName: "Momma",
};

console.log(greet(person));