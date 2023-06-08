import pytest
import app

@pytest.fixture()
def app():
    app.config.update({
        "TESTING": True,
    })

    yield app


@pytest.fixture()
def client(app):
    return app.test_client()


@pytest.fixture()
def runner(app):
    return app.test_cli_runner()


def test_register(client):
    response = client.post("/register", data={
        "name": "ABC",
        "email": "abc@gmail.com",
        "username": "abc001",
        "password": "12345",
    })
    assert response.status_code == 200


def test_login(client):
    response = client.post("/login", data={
        "username": "abc001",
        "password": "12345",
    })
    assert response.status_code == 200


def test_chats(client):
    response = client.get("/chats")
    assert response.data


def test_chatting(client):
    response = client.post("/chatting/<string:id>", data={
        "body": "Hi, How are u ?",
    })
    assert response.status_code == 200