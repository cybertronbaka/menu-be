module GraphqlHelpers
    def controller
        @controller = GraphqlController.new.tap do |obj|
            obj.set_request! ActionDispatch::Request.new({})
        end
    end

    def execute_graphql(query, **kwargs)
        NyemenuBeSchema.execute(
            query,
            context: { controller: controller },
        )
    end
end