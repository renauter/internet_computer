import CanDB "mo:candb/CanDB";
import Entity "mo:candb/Entity";

actor {
    private let initArgs : CanDB.DBInitOptions = {
        pk = "user";
        scalingOptions = {
            autoScalingHook = scale;
            sizeLimit = #count(999_000_000_000);
        };
        btreeOrder = null;
    };

    stable var db = CanDB.init(initArgs);

    public shared func scale(t : Text) : async Text { t };

    type User = {
        name: Text;
        age: Nat;
    };

    // Define a function to add a user
    public shared func addUser(name: Text, age: Nat) : async Text {
        let entity : CanDB.Entity = {
            pk = "user";
            sk = name;  // Using name as the sort key
            attributes = [
                ("name", #text(name)),
                ("age", #int(age))
            ];
        };

        await CanDB.put(db, entity);
        "User added successfully"
    };

    // Define a function to get a user
    public query func getUser(name: Text) : async ?User {
        let result = CanDB.get(db, { pk = "user"; sk = name });
        switch (result) {
            case (null) { null };
            case (?entity) {
                ?{
                    name = switch (Entity.getAttributeMapValueForKey(entity.attributes, "name")) {
                        case (?#text(t)) { t };
                        case (_) { "" };
                    };
                    age = switch (Entity.getAttributeMapValueForKey(entity.attributes, "age")) {
                        case (?#int(n)) { n };
                        case (_) { 0 };
                    };
                }
            };
        }
    };

    public query func size() : async Nat { db.count };
}