resource "aws_key_pair" "mykeypair" {
    key_name = "keyaws"
    public_key = file("keyaws.pub")
}
