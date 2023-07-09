import supertest from "supertest";
import { web } from "../app/web";
import { prismaClient } from "../app/database";

describe("POST /api/users", function () {

    afterEach(async () => {
        await prismaClient.user.deleteMany({
            where: {
                username: "berryl"
            }
        })
    })

    it("should can register new user", async ()=>{
        const result = await supertest(web)
        .post("/api/users")
        .send({
            username: "berryl",
            password: "berryl123",
            neme: "berryl radian"
        });

        expect(result.status).toBe(200);
        expect(result.body.data.username).toBe("berryl");
        expect(result.body.data.name).toBe("berryl radian");
        expect(result.body.data.password).toBeUndefined();
    });

    it("should reject if request is invalid", async ()=>{
        const result = await supertest(web)
        .post("/api/users")
        .send({
            username: "",
            password: "",
            neme: ""
        });

        expect(result.status).toBe(400);
        expect(result.body.data.errors).toBeDefined();
    });

    it("should can register new user", async ()=>{
        let result = await supertest(web)
        .post("/api/users")
        .send({
            username: "berryl",
            password: "berryl123",
            neme: "berryl radian"
        });

        expect(result.status).toBe(200);
        expect(result.body.data.username).toBe("berryl");
        expect(result.body.data.name).toBe("berryl radian");
        expect(result.body.data.password).toBeUndefined();

        result = await supertest(web)
        .post("/api/users")
        .send({
            username: "berryl",
            password: "berryl123",
            neme: "berryl radian"
        });

        expect(result.status).toBe(400);
        expect(result.body.data.errors).toBeDefined();
    });
});