#!/bin/sh
echo "-----------------------------"
echo "Training cats&dogs model"
scripts/train_catsdogs.sh
echo "-----------------------------"
echo "Training mnist model"
scripts/train_mnist.sh
echo "-----------------------------"
echo "Training mnist_extrasmall model"
scripts/train_mnist_extrasmall.sh
echo "-----------------------------"
echo "Training cifar10 model"
scripts/train_cifar10.sh
echo "-----------------------------"
echo "Training cifar100 model without QAT"
scripts/train_cifar100.sh
echo "-----------------------------"
echo "Training cifar100 model with 8-bit QAT"
scripts/train_cifar100_qat8.sh
echo "-----------------------------"
echo "Training cifar100 model with mixed bit width QAT"
scripts/train_cifar100_qat_mixed.sh
echo "-----------------------------"
echo "Training cifar100_residual model"
scripts/train_cifar100_ressimplenet.sh
echo "-----------------------------"
echo "Training kws20 model"
scripts/train_kws20.sh
echo "-----------------------------"
echo "Training kws20_v2 model"
scripts/train_kws20_v2.sh
echo "-----------------------------"
echo "Training faceid model"
scripts/train_faceid.sh

