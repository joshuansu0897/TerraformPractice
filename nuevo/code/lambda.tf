resource "aws_lambda_function" "lambda_public" {
  filename         = "lambda_function.zip"
  function_name    = "lambda_public"
  role             = aws_iam_role.iam_for_lambda_public.arn
  handler          = "index.handler"
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256
  runtime          = "nodejs8.10"

  environment {
    variables = {
      ELB_ENDPOINT = aws_elb.public_elb.dns_name
    }
  }
}

resource "aws_lambda_function" "lambda_private" {
  filename         = "lambda_function.zip"
  function_name    = "lambda_private"
  role             = aws_iam_role.iam_for_lambda_private.arn
  handler          = "index.handler"
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256
  runtime          = "nodejs8.10"

  vpc_config {
    subnet_ids         = aws_subnet.private_subnets.*.id
    security_group_ids = ["${aws_security_group.private_sg.id}"]
  }

  environment {
    variables = {
      ELB_ENDPOINT = aws_elb.private_elb.dns_name
    }
  }
}
