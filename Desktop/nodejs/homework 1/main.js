import { sleep } from './sleep.js';
import { getRandomNumber } from './random.js';
import { Person } from './person.js';

const person = new Person("Faxriddin Maripov", 2000);

const delay = getRandomNumber(); 
console.log(`Waiting for ${delay} milliseconds...`);

await sleep(delay);

console.log(person.getInfo());
