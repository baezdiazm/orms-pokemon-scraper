class Pokemon
    attr_accessor :id, :name, :type, :db

    def initialize(id:, name:, type:, db:)
        @id = id
        @name = name
        @type = type
        @db = db
    end

    def self.save(name, type, db)
        sql = <<-AYO
            INSERT INTO pokemon (name, type)
            VALUES (?, ?)
        AYO
        db.execute(sql, name, type)
        @id = db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
    end

    def self.find(id, db)
        pokes = db.execute("SELECT * FROM pokemon WHERE id = ? LIMIT 1", id).flatten
        #binding.pry
        self.new(id: pokes[0], name: pokes[1], type: pokes[2], db: db)
    end
end
