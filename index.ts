import { parse }  from "./grammer";
import * as fs from "fs";

const content = fs.readFileSync(process.argv[2], { encoding: "utf8"});

try {
    console.log(parse(content));
} catch(err) {
    console.error(err.toString());
}