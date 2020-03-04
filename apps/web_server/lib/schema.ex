defmodule Graphql.Schema do
  use Absinthe.Schema

  query do
    field :is_this_thing_on, type: :string do
      resolve(fn _, _ -> {:ok, "Yes!"} end)
    end
  end
end
