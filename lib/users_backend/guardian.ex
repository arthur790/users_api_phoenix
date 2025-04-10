defmodule UsersBackend.Guardian do
  use Guardian, otp_app: :users_backend


  def subject_for_token(%{uuid: uuid}, _claims) do
    # You can use any value for the subject of your token but
    # it should be useful in retrieving the resource later, see
    # how it being used on `resource_from_claims/1` function.
    # A unique `id` is a good subject, a non-unique email address
    # is a poor subject.
    sub = to_string(uuid)
    {:ok, sub}
  end

  def subject_for_token(_, _) do
    {:error, :reason_for_error}
  end

  def resource_from_claims(%{"sub" => uuid}) do
    # Here we'll look up our resource from the claims, the subject can be
    # found in the `"sub"` key. In above `subject_for_token/2` we returned
    # the resource id so here we'll rely on that to look it up.
    case UsersBackend.Users.get_user!(uuid) do
      nil -> {:error, :reason_for_error}
      resource -> {:ok, resource}
    end
  end

  def resource_from_claims(_claims) do
    {:error, :reason_for_error}
  end

  def authenticate( email, password) do
    case UsersBackend.Users.get_user_by_email(email) do
      nil ->
        {:error, :unauthorized}

      resource ->
        case validate_password(password, resource.password) do
          true -> create_token(resource)
          false -> {:error, :reason_for_error}
        end
    end
  end

  def validate_password(password, hash_password) do
    Bcrypt.verify_pass(password, hash_password)
  end

  defp create_token(user) do
    {:ok, token, _full_claims} = encode_and_sign(user)

    {:ok, user, token}
 end
end
