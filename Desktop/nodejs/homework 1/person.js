export class Person {
    constructor(fullName, birthYear) {
        this.fullName = fullName;
        this.birthYear = birthYear;
    }

    get age() {
        return new Date().getFullYear() - this.birthYear;
    }

    getInfo() {
        return `Full Name: ${this.fullName}, Age: ${this.age}`;
    }
}
